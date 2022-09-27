/// Tests for QCloudCosAPIClient

import "package:flutter_test/flutter_test.dart";
import "package:http/http.dart" as http;

import 'package:flutter_qcloud_cos/src/api/client.dart';



void main(){
  test('requestCosAPI',() async {
    QCloudCosAPIClient cosClient = QCloudCosAPIClient(
        secretId: '',
        secretKey: ''
    );
    http.StreamedResponse response = await cosClient.requestCosAPI(
      method: 'GET',
      host: '',
      path: '',
    );
  }, skip: 'not finished yet');
}
