/// Base API Client for QCloud COS

import 'package:http/http.dart' as http;

import '../../flutter_qcloud_cos.dart';
import 'sign.dart';


/// Base API Client with Low-level APIs for QCloud COS
class QCloudCosBaseAPIClient {
  const QCloudCosBaseAPIClient({
    required String secretId,
    required String secretKey,
  });

  Future<http.StreamedResponse> requestCosAPI({
        required String method,
        required String host,
        required String path,
        Map<String, dynamic>? queryParams,
        Map<String, String>? headers
      }) async {
    http.Client client = http.Client();
    queryParams = queryParams ?? {};
    Uri url = Uri.https(host, path, queryParams);
    http.StreamedRequest request = http.StreamedRequest(method, url);
    headers = headers ?? {};
    request.headers.clear();
    request.headers.addAll(headers);
    return client.send(request);
  }

  Future<http.StreamedResponse> requestCosBucketAPI({
    required String appId,
    required String region,
    required String bucket,
    required String method,
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers
  }) async {
    http.StreamedResponse response = await requestCosAPI(
      method: method,
      host: '$bucket-$appId.cos.$region.myqcloud.com',
      path: path,
      queryParams: queryParams,
      headers: headers,
    );
    return response;
  }
}
