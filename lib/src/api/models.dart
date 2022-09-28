/// Models for APIClient

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';


class QCloudCosAPIResponse {
  /// 原始响应
  final http.StreamedResponse rawResponse;

  const QCloudCosAPIResponse({
    required this.rawResponse,
  });

  /// 状态码
  get statusCode => rawResponse.statusCode;

  /// 原始文件流
  get stream => rawResponse.stream;

  /// 响应报文长度
  get contentLength => rawResponse.contentLength;

  /// 响应类型
  get contentType => rawResponse.headers['content-type'];

  /// CRC64
  get crc64 => rawResponse.headers['x-cos-hash-crc64ecma'];

  /// 解析后的响应数据
  /// TODO: 临时实现。无法区分原始数据为XML的情况。
  get content async {
    if (contentType == 'application/xml'){
      String xmlRawContent = await stream.transform(utf8.decoder).join("");
      return XmlDocument.parse(xmlRawContent);
    }
    // TODO
    return await stream;
  }
}