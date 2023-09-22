import 'package:ble_temperature/core/typedefs/typedefs.dart';

import 'package:ble_temperature/src/device_information/domain/entities/android_info.dart';
import 'package:ble_temperature/src/device_information/domain/entities/ios_info.dart';

abstract class DeviceInfoRepository {
  ResultFuture<AndroidInfo> getAndroidInfo();
  ResultFuture<IOSInfo> getIOSInfo();
  ResultFuture<DataMap> getInfo();
}
