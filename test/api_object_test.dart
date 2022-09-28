/// Tests for Object APIs


import "package:flutter_test/flutter_test.dart";
import 'package:http/http.dart' as http;

import 'package:flutter_qcloud_cos/src/api/client.dart';
import 'package:flutter_qcloud_cos/src/api/models.dart';
import 'environment_config.dart';


void main(){
  test('getObject',() async {
    QCloudCosAPIClient cosClient = QCloudCosAPIClient(
      secretId: EnvironmentConfig.secretId,
      secretKey: EnvironmentConfig.secretKey,
      defaultRegion: EnvironmentConfig.defaultRegion,
      defaultBucket: EnvironmentConfig.defaultBucket,
    );
    QCloudCosAPIResponse response = await cosClient.getObject(objectKey: EnvironmentConfig.defaultObjectKey);
    expect(response.statusCode, 200);
    expect(response.contentLength, EnvironmentConfig.defaultObjectContentLength);
    String content = await response.stream.bytesToString();
    expect(content, EnvironmentConfig.defaultObjectContent);
  });
}
