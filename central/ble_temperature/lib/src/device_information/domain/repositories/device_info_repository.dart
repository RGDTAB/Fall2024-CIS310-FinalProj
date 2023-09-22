import 'package:ble_temperature/core/typedefs/typedefs.dart';

import '../entities/android_info.dart';
import '../entities/ios_info.dart';

abstract class DeviceInfoRepository {
  ResultFuture<AndroidInfo> getAndroidInfo();
  ResultFuture<IOSInfo> getIOSInfo();
  ResultFuture<DataMap> getInfo();
}
