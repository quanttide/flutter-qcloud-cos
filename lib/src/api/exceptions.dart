/// Exception classes for APIClient

import 'models.dart';


class QCloudCosAPIException implements Exception {
  final QCloudCosAPIResponse response;

  QCloudCosAPIException({
    required this.response
  });

  /// 状态码
  get statusCode => response.statusCode;

  /// 异常信息
  get content => response.content;

  @override
  String toString(){
    return "status code: $statusCode\nerror message: $content\n";
  }
}