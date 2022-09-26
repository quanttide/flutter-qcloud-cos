/// Utils

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';


/// HMAC-SHA1摘要
String hmacSha1(String msg, String key) {
  return hex.encode(Hmac(sha1, key.codeUnits).convert(msg.codeUnits).bytes);
}

String hexSha1(String msg){
  return hex.encode(sha1.convert(msg.codeUnits).bytes);
}
