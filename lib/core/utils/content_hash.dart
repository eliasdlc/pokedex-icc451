import 'dart:convert';

import 'package:crypto/crypto.dart';

String contentHash(List<Object?> canonicalValues) {
  final json = jsonEncode(canonicalValues);
  return sha1.convert(utf8.encode(json)).toString();
}
