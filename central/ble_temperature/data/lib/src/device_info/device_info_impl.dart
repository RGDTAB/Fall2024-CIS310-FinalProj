import 'dart:io' show Platform;

import 'package:data/src/device_info/ios_info_adapter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:domain/domain.dart';

import 'android_info_adapter.dart';

class DeviceInfoImpl implements DeviceInfoFacade {
  @override
  Future<AndroidInfo> getAndroidInfo() async {
    if (!Platform.isAndroid) {
      throw Exception('Wrong platform.');
    }

    return AndroidInfoAdapter().from(await DeviceInfoPlugin().androidInfo);
  }

  @override
  Future<IOSInfo> getIOSInfo() async {
    if (!Platform.isIOS) {
      throw Exception('Wrong platform.');
    }

    return IOSInfoAdapter().from(await DeviceInfoPlugin().iosInfo);
  }

  @override
  Future<Map<String, dynamic>> getInfo() async {
    final info = await DeviceInfoPlugin().deviceInfo;
    return info.data;
  }
}
