import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../config/app_config.dart';

enum MediaKind { art, cries }

class MediaCache {
  MediaCache({http.Client? client, Future<Directory> Function()? baseDir})
    : _client = client ?? http.Client(),
      _baseDir = baseDir ?? getApplicationDocumentsDirectory;

  final http.Client _client;
  final Future<Directory> Function() _baseDir;

  final _enCurso = <String, Future<File?>>{};

  Future<File?> enDisco(Uri url, MediaKind kind) async {
    final file = await _archivo(url, kind);
    return file == null ? null : _siEsValido(file);
  }

  Future<File?> obtener(Uri url, MediaKind kind) async {
    final file = await _archivo(url, kind);
    if (file == null) return null;
    return guardarEn(url, file);
  }

  Future<File?> guardarEn(Uri url, File destino) {
    final existente = _siEsValido(destino);
    if (existente != null) return Future.value(existente);
    return _enCurso[destino.path] ??= _descargar(url, destino).whenComplete(() {
      _enCurso.remove(destino.path);
    });
  }

  Future<File?> _descargar(Uri url, File destino) async {
    try {
      final response = await _client
          .get(url, headers: const {'User-Agent': AppConfig.userAgent})
          .timeout(AppConfig.requestTimeout);
      if (response.statusCode != 200 || response.bodyBytes.isEmpty) return null;
      await destino.parent.create(recursive: true);
      final temporal = File('${destino.path}.part');
      await temporal.writeAsBytes(response.bodyBytes, flush: true);
      await temporal.rename(destino.path);
      return destino;
    } on Exception {
      return null;
    }
  }

  File? _siEsValido(File file) =>
      file.existsSync() && file.lengthSync() > 0 ? file : null;

  Future<File?> _archivo(Uri url, MediaKind kind) async {
    try {
      final raiz = await _baseDir();
      final nombre = sha1.convert(url.toString().codeUnits).toString();
      return File(
        p.join(
          raiz.path,
          'media',
          kind.name,
          '$nombre${p.extension(url.path)}',
        ),
      );
    } on Exception {
      return null;
    }
  }
}
