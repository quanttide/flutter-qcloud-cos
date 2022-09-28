/// Object API Mixin

import 'base.dart';
import 'models.dart';


mixin QCloudCosObjectAPIMixin on QCloudCosBaseAPIClient {
  Future<QCloudCosAPIResponse> getObject({
    String? region,
    String? bucket,
    required String objectKey,
  }){
    return requestCosBucketAPI(
        region: region,
        bucket: bucket,
        method: 'GET',
        path: '/$objectKey',
    );
  }
}