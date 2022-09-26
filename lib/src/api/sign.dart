/// Signature for QCloud COS Authorization
///
/// Following official documentation
/// https://cloud.tencent.com/document/product/436/7778
/// and official validation tool
/// https://cloud.tencent.com/document/product/436/30442
///
/// Originally based on Python package `qcloud-sdk-py` (Apache 2.0)
/// https://github.com/quanttide/qcloud-sdk-py/blob/master/qcloud_sdk/cos/sign.py
/// See https://github.com/quanttide/qcloud-sdk-py/blob/main/LICENSE for original license.
///
/// Originally based on Flutter package `tencent_cos` (Apache 2.0)
/// https://github.com/zhangruiyu/tencent_cos/blob/main/lib/src/cos_clientbase.dart
/// See https://github.com/zhangruiyu/tencent_cos/blob/main/LICENSE for original license.


import 'utils.dart';

/// 步骤1：生成KeyTime
String joinKeyTime(int beginTime, int expire){
  return "$beginTime;${beginTime+expire}";
}

/// 步骤2：生成SignKey
String calculateSignKey(String keyTime, String secretKey){
  return hmacSha1(keyTime, secretKey);
}

/// 步骤3和4的通用函数
///   - 步骤3：生成UrlParamList
///   - 步骤4：生成HeaderList
String joinUrlParamList(Map<String, dynamic> params){
  List keys = params.keys.map((key) => key.toLowerCase()).toList();
  keys.sort();
  String urlParamList = keys.join(";");
  return urlParamList;
}

/// 步骤3和4的通用函数
///   - 步骤3：生成HttpParameters
///   - 步骤4：生成HttpHeaders
String joinHttpParams(Map<String, dynamic> params){
  params = params.map((key, value) => MapEntry(
      Uri.encodeComponent(key).toLowerCase(),
      Uri.encodeComponent((value!=null)?value.toString():"")
  ));
  List keys = params.keys.toList();
  keys.sort();
  String httpParameters = keys.map((e) => e + "=" + (params[e] ?? "")).join("&");
  return httpParameters ;
}

/// 步骤5：生成HttpString
String joinHttpString(String method, String path, String httpParams, String headers){
  return '${method.toLowerCase()}\n$path\n$httpParams\n$headers\n';
}

/// 步骤6
String calculateStringToSign(String keyTime, String httpString){
  String httpStringSha1 = hexSha1(httpString);
  return 'sha1\n$keyTime\n$httpStringSha1\n';
}

/// 步骤7
String calculateSignature(String signKey, String stringToSign){
  return hmacSha1(stringToSign, signKey);
}

/// 步骤8：生成签名
String joinAuthString(String secretId, String keyTime, String headerList, String urlParamList, String signature){
  return ['q-sign-algorithm=sha1', 'q-ak=$secretId', 'q-sign-time=$keyTime',
    'q-key-time=$keyTime', 'q-header-list=$headerList', 'q-url-param-list=$urlParamList',
    'q-signature=$signature'].join('&');
}

/// 主函数
String calculateAuthString(
    String method, String path,
    Map<String, dynamic>? queryParams, Map<String, String>? headers,
    String secretId, String secretKey,
    {
      int? beginTime,
      int? expire,
    }){
  queryParams = queryParams ?? {};
  headers = headers ?? {};
  beginTime = beginTime ?? DateTime.now().millisecondsSinceEpoch ~/ 1000;
  expire = expire ?? 3600;
  // 步骤1：生成KeyTime
  String keyTime = joinKeyTime(beginTime, expire);
  // 步骤2：生成SignKey
  String signKey = calculateSignKey(keyTime, secretKey);
  // 步骤3：生成UrlParamList和HttpParameters
  String urlParamList = joinUrlParamList(queryParams);
  String httpParams = joinHttpParams(queryParams);
  // 步骤4：生成HeaderList和HttpHeaders
  String headerList = joinUrlParamList(headers);
  String httpHeaders = joinHttpParams(headers);
  // 步骤5：生成HttpString
  String httpString = joinHttpString(method, path, httpParams, httpHeaders);
  // 步骤6：生成StringToSign
  String stringToSign = calculateStringToSign(keyTime, httpString);
  // 步骤7：生成Signature
  String signature = calculateSignature(signKey, stringToSign);
  // 步骤8：生成签名
  return joinAuthString(secretId, keyTime, headerList, urlParamList, signature);
}
