import 'dart:convert';

import 'package:crypto/crypto.dart';

class Cryptography {
  String hashStringWithSha512(String input) {
    var bytes = utf8.encode(input);
    var digest = sha512.convert(bytes);
    return digest.toString();
  }
}
