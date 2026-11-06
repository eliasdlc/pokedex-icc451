@Tags(['live'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/core/network/api_failure_simulator.dart';
import 'package:pokedex/features/pokedex/data/remote/pokeapi_remote_data_source.dart';

void main() {
  final simulator = ApiFailureSimulator();
  final remote = GraphQLPokeApiRemoteDataSource(simulator: simulator);

  test('la sonda responde', () async => expect(await remote.probe(), isTrue));

  test('ids del catálogo: 1025 especies por defecto', () async {
    final ids = await remote.fetchCatalogIds();
    expect(ids.length, greaterThanOrEqualTo(1025));
    expect(ids.first, 1);
  });

  test('resumen por ids con nombres en español', () async {
    final items = await remote.fetchByIds([1, 25, 133]);
    expect(items.map((e) => e.id), [1, 25, 133]);
    expect(items[1].nameEs, 'Pikachu');
    expect(items[0].types.length, 2);
    expect(items[0].spriteUrl, startsWith('https://'));
    expect(remote.lastDiscarded, 0);
  });

  test('detalle de Eevee: rama evolutiva y habilidad oculta', () async {
    final detail = await remote.fetchDetail(133);
    expect(
      detail.evolutions.where((e) => e.fromSpeciesId == 133).length,
      greaterThanOrEqualTo(8),
    );
    expect(detail.abilities.any((a) => a.isHidden), isTrue);
    expect(detail.flavorEs, isNotNull);
    expect(detail.moves, isNotEmpty);
  });

  test(
    'detalle de Raichu: formas, versiones y métodos de aprendizaje',
    () async {
      final detail = await remote.fetchDetail(26);
      final alola = detail.varieties.firstWhere((v) => v.id == 10100);
      expect(alola.isDefault, isFalse);
      expect(alola.speciesId, 26);
      expect(alola.formNameEs, 'Forma de Alola');
      expect(alola.types.length, 2);
      final methods = {for (final l in detail.learnset) l.methodId};
      expect(methods, containsAll([1, 4]));
      expect(
        {for (final l in detail.learnset) l.versionGroupId}.length,
        greaterThan(10),
      );
      // Cada id del aprendizaje tiene su movimiento en la raíz `move`.
      final moveIds = {for (final m in detail.moves) m.id};
      expect(detail.learnset.every((l) => moveIds.contains(l.moveId)), isTrue);
    },
  );

  test('datos estáticos: 18 tipos y 324 efectividades', () async {
    final data = await remote.fetchStaticData();
    expect(data.types.length, 18);
    expect(data.efficacy.length, 324);
    expect(data.generations.last.region, 'paldea');
    expect(data.abilities.length, greaterThan(250));
    expect(data.versionGroups.first.slug, 'red-green-japan');
    expect(data.versionGroups.length, greaterThan(25));
  });

  test('con la caída simulada falla como servicio no disponible', () async {
    simulator.isApiDown = true;
    await expectLater(
      remote.fetchCatalogIds(),
      throwsA(isA<ServiceUnavailableFailure>()),
    );
    expect(await remote.probe(), isFalse);
    simulator.isApiDown = false;
  });
}
