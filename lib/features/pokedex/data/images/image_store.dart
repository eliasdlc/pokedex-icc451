import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../../core/media/media_cache.dart';

/// Persistencia de imágenes: los archivos van al almacenamiento de la app y
/// su ruta a la base. A diferencia de un caché de imágenes, la base sabe qué
/// imagen tiene cada Pokémon y la puede mostrar offline o borrar con él.
abstract interface class ImageStore {
  Future<String?> save(
    String url, {
    required String kind,
    required int pokemonId,
  });
}

class FileImageStore implements ImageStore {
  FileImageStore({http.Client? client, Future<Directory> Function()? baseDir})
    : _cache = MediaCache(client: client),
      _baseDir = baseDir ?? getApplicationSupportDirectory;

  final MediaCache _cache;
  final Future<Directory> Function() _baseDir;

  @override
  Future<String?> save(
    String url, {
    required String kind,
    required int pokemonId,
  }) async {
    final uri = Uri.parse(url);
    final dir = Directory(p.join((await _baseDir()).path, 'images', kind));
    final file = File(p.join(dir.path, '$pokemonId${p.extension(uri.path)}'));
    return (await _cache.guardarEn(uri, file))?.path;
  }
}
