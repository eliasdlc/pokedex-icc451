import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;

import '../../../../core/config/app_config.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_failure_simulator.dart';
import 'dtos.dart';
import 'queries.dart';

abstract interface class PokeApiRemoteDataSource {
  Future<bool> probe();
  Future<List<int>> fetchCatalogIds();
  Future<List<PokemonSummaryDto>> fetchByIds(List<int> ids);
  Future<PokemonDetailDto> fetchDetail(int id);
  Future<StaticDataDto> fetchStaticData();

  int get lastDiscarded;
}

class GraphQLPokeApiRemoteDataSource implements PokeApiRemoteDataSource {
  GraphQLPokeApiRemoteDataSource({
    required this.simulator,
    http.Client? httpClient,
  }) {
    final link = HttpLink(
      AppConfig.graphqlEndpoint,
      httpClient: httpClient ?? http.Client(),
      // Sin User-Agent, PokéAPI responde 403 Forbidden.
      defaultHeaders: const {'User-Agent': AppConfig.userAgent},
    );
    // El caché del cliente queda en memoria y sin uso (noCache): la fuente de
    // verdad es la base Drift, no la caché normalizada de GraphQL.
    _client = GraphQLClient(link: link, cache: GraphQLCache());
  }

  final ApiFailureSimulator simulator;
  late final GraphQLClient _client;

  @override
  int lastDiscarded = 0;

  Future<Json> _run(
    String document, {
    Map<String, Object?> variables = const {},
    Duration timeout = AppConfig.requestTimeout,
  }) async {
    if (simulator.isApiDown) {
      throw const ServiceUnavailableFailure(
        'Caída de la API simulada (Laboratorio)',
      );
    }
    debugPrint('graphql: ${_operationName(document)} $variables');
    final QueryResult<Object?> result;
    try {
      result = await _client
          .query(
            QueryOptions(
              document: gql(document),
              variables: variables,
              fetchPolicy: FetchPolicy.noCache,
            ),
          )
          .timeout(timeout);
    } on TimeoutException {
      throw ServiceUnavailableFailure(
        'Sin respuesta en ${timeout.inSeconds} s',
      );
    } on SocketException catch (e) {
      throw NoConnectionFailure(e.message);
    }

    final data = result.data;
    final exception = result.exception;
    if (exception != null) {
      final link = exception.linkException;
      if (link != null) throw _mapLinkException(link);

      if (data == null) {
        throw GraphQLFailure(
          exception.graphqlErrors.map((e) => e.message).join('; '),
        );
      }
    }
    if (data == null) throw const InvalidDataFailure('Respuesta vacía');
    return data;
  }

  static String _operationName(String document) =>
      RegExp(r'query (\w+)').firstMatch(document)?.group(1) ?? 'query';

  Failure _mapLinkException(LinkException link) {
    if (link is HttpLinkServerException) {
      final code = link.response.statusCode;
      if (code == 429) return const RateLimitedFailure();
      return ServiceUnavailableFailure('HTTP $code');
    }
    if (link is NetworkException) {
      final message = '${link.originalException}';
      return message.contains('Failed host lookup')
          ? NoConnectionFailure(message)
          : ServiceUnavailableFailure(message);
    }
    if (link is ServerException) {
      return ServiceUnavailableFailure(
        '${link.originalException ?? 'Error de servidor'}',
      );
    }
    return ServiceUnavailableFailure('$link');
  }

  /// Convierte cada fila con su validador y cuenta las descartadas.
  List<T> _parseEach<T>(Json data, String key, T Function(Json) parse) {
    final rows = (data[key] as List<Object?>? ?? const []).cast<Json>();
    final parsed = <T>[];
    var discarded = 0;
    for (final row in rows) {
      try {
        parsed.add(parse(row));
      } on InvalidDataFailure {
        discarded++;
      }
    }
    lastDiscarded = discarded;
    return parsed;
  }

  @override
  Future<bool> probe() async {
    try {
      await _run(healthQuery, timeout: AppConfig.healthProbeTimeout);
      return true;
    } on Failure {
      return false;
    }
  }

  @override
  Future<List<int>> fetchCatalogIds() async {
    final data = await _run(catalogIdsQuery);
    final rows = (data['pokemon'] as List<Object?>? ?? const []).cast<Json>();
    final ids = [for (final row in rows) row['id']].whereType<int>().toList();
    if (ids.isEmpty) {
      throw const InvalidDataFailure('La API devolvió un catálogo vacío');
    }
    return ids;
  }

  @override
  Future<List<PokemonSummaryDto>> fetchByIds(List<int> ids) async {
    final data = await _run(catalogByIdsQuery, variables: {'ids': ids});
    return _parseEach(data, 'pokemon', PokemonSummaryDto.fromJson);
  }

  @override
  Future<PokemonDetailDto> fetchDetail(int id) async {
    final data = await _run(detailQuery, variables: {'id': id});
    final moves = (data['move'] as List<Object?>? ?? const []).cast<Json>();
    final list = _parseEach(
      data,
      'pokemon',
      (row) => PokemonDetailDto.fromJson(row, moves: moves),
    );
    if (list.isEmpty) throw InvalidDataFailure('Detalle de $id no disponible');
    return list.single;
  }

  @override
  Future<StaticDataDto> fetchStaticData() async =>
      StaticDataDto.fromJson(await _run(staticDataQuery));
}
