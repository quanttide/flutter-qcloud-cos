/// Base API Client for QCloud COS

import 'package:http/http.dart' as http;

import 'exceptions.dart';
import 'sign.dart';
import 'models.dart';


/// Base API Client with Low-level APIs for QCloud COS
class QCloudCosBaseAPIClient extends http.BaseClient {
  final String secretId;
  final String secretKey;
  final String? sessionToken;
  final String? defaultRegion;
  final String? defaultBucket;

  QCloudCosBaseAPIClient({
    required this.secretId,
    required this.secretKey,
    this.sessionToken,
    this.defaultRegion,
    this.defaultBucket,
  });

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    http.Client client = http.Client();
    http.StreamedResponse response = await client.send(request).timeout(
        const Duration(seconds: 10)
    );
    return response;
  }

  Future<QCloudCosAPIResponse> requestCosAPI({
        required String method,
        required String host,
        required String path,
        Map<String, dynamic>? queryParams,
        Map<String, String>? headers
      }) async {
    // 请求
    queryParams = queryParams ?? {};
    Uri url = Uri.https(host, path, queryParams);
    http.Request request = http.Request(method, url);

    headers = headers ?? {};
    headers['Host'] = host;
    if (sessionToken!=null){
      headers['x-cos-security-token'] = sessionToken!;
    }
    headers['Authorization'] = calculateAuthString(method, path, queryParams, headers, secretId, secretKey);
    request.headers.clear();
    request.headers.addAll(headers);
    // 响应
    http.StreamedResponse rawResponse = await send(request);
    QCloudCosAPIResponse response = QCloudCosAPIResponse(rawResponse: rawResponse);
    if (response.statusCode >= 400){
      throw QCloudCosAPIException(response: response);
    }
    return response;
  }

  Future<QCloudCosAPIResponse> requestCosBucketAPI({
    String? region,
    String? bucket,
    required String method,
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers
  }) async {
    // 处理参数
    region = region ?? defaultRegion;
    assert(region!=null);
    bucket = bucket ?? defaultBucket;
    assert(bucket!=null);
    // 请求API
    QCloudCosAPIResponse response = await requestCosAPI(
      method: method,
      host: '$bucket.cos.$region.myqcloud.com',
      path: path,
      queryParams: queryParams,
      headers: headers,
    );
    return response;
  }
}
