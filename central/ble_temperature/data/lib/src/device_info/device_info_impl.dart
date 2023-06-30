import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:domain/domain.dart';

class DeviceInfoImpl implements DeviceInfoFacade {
  @override
  Future<AndroidInfo> getAndroidInfo() async {
    if (!Platform.isAndroid) {
      throw Exception('Wrong platform.');
    }

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return AndroidInfo(sdkInt: androidInfo.version.sdkInt);
  }

  @override
  Future<IOSInfo> getIOSInfo() async {
    if (!Platform.isIOS) {
      throw Exception('Wrong platform.');
    }

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return Future.value(IOSInfo(systemVersion: iosInfo.systemVersion!));
  }

  @override
  Future<Map<String, dynamic>> getInfo() async {
    BaseDeviceInfo info = await DeviceInfoPlugin().deviceInfo;
    return info.data;
  }
}
