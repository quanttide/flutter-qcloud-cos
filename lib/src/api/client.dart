/// API Client for QCloud COS

import 'base.dart';
import 'service.dart';
import 'bucket.dart';
import 'object.dart';


/// API Client for QCloud COS
class QCloudCosAPIClient extends QCloudCosBaseAPIClient with
    QCloudCosServiceAPIMixin,
    QCloudCosBucketAPIMixin,
    QCloudCosObjectAPIMixin {

  QCloudCosAPIClient({
    required super.secretId,
    required super.secretKey,
    super.defaultRegion,
    super.defaultBucket,
  });
}
