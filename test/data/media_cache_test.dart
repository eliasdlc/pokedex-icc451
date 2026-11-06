import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:path/path.dart' as p;
import 'package:pokedex/core/media/media_cache.dart';

void main() {
  late Directory temp;
  late List<Uri> requests;
  var online = true;
  var status = 200;

  MediaCache cacheWith({Duration? delay}) => MediaCache(
    baseDir: () async => temp,
    client: MockClient((request) async {
      requests.add(request.url);
      if (delay != null) await Future<void>.delayed(delay);
      if (!online) throw const SocketException('sin red');
      return http.Response.bytes(status == 200 ? [1, 2, 3, 4] : [], status);
    }),
  );

  final art = Uri.parse('https://x.test/other/home/25.png');
  final cry = Uri.parse('https://x.test/cries/25.ogg');

  setUp(() {
    temp = Directory.systemTemp.createTempSync('media_cache_test');
    requests = [];
    online = true;
    status = 200;
  });

  tearDown(() => temp.deleteSync(recursive: true));

  test(
    'descarga una vez y después sirve el archivo local, también sin red',
    () async {
      final cache = cacheWith();
      final first = await cache.obtener(art, MediaKind.art);
      expect(first, isNotNull);
      expect(first!.readAsBytesSync(), [1, 2, 3, 4]);
      expect(
        first.path,
        contains('${p.separator}media${p.separator}art${p.separator}'),
      );
      expect(first.path, endsWith('.png'));

      online = false;
      final second = await cache.obtener(art, MediaKind.art);
      expect(second!.path, first.path);
      expect(requests, hasLength(1));
    },
  );

  test('cada tipo va a su subcarpeta', () async {
    final cache = cacheWith();
    final file = await cache.obtener(cry, MediaKind.cries);
    expect(file!.path, contains('${p.separator}cries${p.separator}'));
    expect(file.path, endsWith('.ogg'));
  });

  test('la ilustración y el 3D con el mismo número no se pisan', () async {
    final cache = cacheWith();
    final a = await cache.obtener(
      Uri.parse('https://x.test/official-artwork/25.png'),
      MediaKind.art,
    );
    final b = await cache.obtener(
      Uri.parse('https://x.test/home/25.png'),
      MediaKind.art,
    );
    expect(a!.path, isNot(b!.path));
  });

  test(
    'enDisco no usa la red: null antes de descargar, archivo después',
    () async {
      final cache = cacheWith();
      expect(await cache.enDisco(art, MediaKind.art), isNull);
      expect(requests, isEmpty);
      await cache.obtener(art, MediaKind.art);
      expect(await cache.enDisco(art, MediaKind.art), isNotNull);
    },
  );

  test('sin red devuelve null y no deja archivos', () async {
    online = false;
    final cache = cacheWith();
    expect(await cache.obtener(art, MediaKind.art), isNull);
    expect(await cache.enDisco(art, MediaKind.art), isNull);
    expect(temp.listSync(recursive: true).whereType<File>(), isEmpty);
  });

  test('un 404 devuelve null y se puede reintentar luego', () async {
    status = 404;
    final cache = cacheWith();
    expect(await cache.obtener(cry, MediaKind.cries), isNull);
    status = 200;
    expect(await cache.obtener(cry, MediaKind.cries), isNotNull);
    expect(requests, hasLength(2));
  });

  test(
    'dos peticiones simultáneas de lo mismo comparten la descarga',
    () async {
      final cache = cacheWith(delay: const Duration(milliseconds: 20));
      final results = await Future.wait([
        cache.obtener(art, MediaKind.art),
        cache.obtener(art, MediaKind.art),
      ]);
      expect(results.every((f) => f != null), isTrue);
      expect(requests, hasLength(1));
    },
  );

  test('un archivo vacío en disco no cuenta como descargado', () async {
    final cache = cacheWith();
    final file = (await cache.obtener(art, MediaKind.art))!;
    file.writeAsBytesSync([]);
    expect(await cache.enDisco(art, MediaKind.art), isNull);
    expect(await cache.obtener(art, MediaKind.art), isNotNull);
    expect(requests, hasLength(2));
  });
}
