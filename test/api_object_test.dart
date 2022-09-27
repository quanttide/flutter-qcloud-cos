/// Tests for Object APIs

import "package:flutter_test/flutter_test.dart";
import "package:http/http.dart" as http;

import 'package:flutter_qcloud_cos/src/api/client.dart';


void main(){
  test('getObject',() async {
    QCloudCosAPIClient cosClient = QCloudCosAPIClient(
        secretId: '',
        secretKey: ''
    );
    await cosClient.getObject();
  }, skip: 'not finished yet');
}
