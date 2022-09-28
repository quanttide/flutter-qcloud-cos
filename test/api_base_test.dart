/// Tests for QCloudCosAPIClient

import "package:flutter_test/flutter_test.dart";

import 'package:flutter_qcloud_cos/src/api/models.dart';
import 'package:flutter_qcloud_cos/src/api/client.dart';



void main(){
  test('requestCosAPI',() async {
    QCloudCosAPIClient cosClient = QCloudCosAPIClient(
      secretId: '',
      secretKey: '',
      defaultRegion: '',
      defaultBucket: '',
    );
    QCloudCosAPIResponse response = await cosClient.requestCosAPI(
      method: 'GET',
      host: '',
      path: '',
    );
  }, skip: 'not finished yet');
}
