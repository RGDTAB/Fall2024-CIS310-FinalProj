import 'dart:io' show Platform;

import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/src/device_information/data/utils/info_extensions.dart';
import 'package:ble_temperature/src/device_information/domain/entities/android_info.dart';
import 'package:ble_temperature/src/device_information/domain/entities/ios_info.dart';
import 'package:device_info_plus/device_info_plus.dart' as info_plus;

abstract class DeviceInfoLocalDataSource {
  Future<AndroidInfo> getAndroidInfo();
  Future<IOSInfo> getIOSInfo();
  Future<DataMap> getInfo();
}

class DeviceInfoLocalDataSourceImpl implements DeviceInfoLocalDataSource {
  @override
  Future<AndroidInfo> getAndroidInfo() async {
    if (!Platform.isAndroid) {
      throw Exception('Wrong platform.');
    }

    final info = await info_plus.DeviceInfoPlugin().androidInfo;
    return info.toAndroidInfo();
  }

  @override
  Future<IOSInfo> getIOSInfo() async {
    if (!Platform.isIOS) {
      throw Exception('Wrong platform.');
    }

    final info = await info_plus.DeviceInfoPlugin().iosInfo;
    return info.toIOSInfo();
  }

  @override
  Future<Map<String, dynamic>> getInfo() async {
    final info = await info_plus.DeviceInfoPlugin().deviceInfo;
    return info.data;
  }
}
