import 'package:ble_temperature/core/typedefs/typedefs.dart';

import 'package:ble_temperature/src/about/domain/entities/app_info.dart';

abstract class AppInfoRepository {
  ResultFuture<AppInfo> getInfo();
}
