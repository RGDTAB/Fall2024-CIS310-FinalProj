import 'package:ble_temperature/core/typedefs/typedefs.dart';

import '../entities/app_info_result.dart';

abstract class AppInfoRepository {
  ResultFuture<AppInfoResult> getInfo();
}
