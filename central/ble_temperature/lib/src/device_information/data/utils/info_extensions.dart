import 'package:ble_temperature/src/device_information/domain/entities/android_info.dart';
import 'package:ble_temperature/src/device_information/domain/entities/ios_info.dart';
import 'package:device_info_plus/device_info_plus.dart' as info_plus;

extension InfoExtensionsAndroid on info_plus.AndroidDeviceInfo {
  AndroidInfo toAndroidInfo() {
    return AndroidInfo(sdkInt: version.sdkInt);
  }
}

extension InfoExtensionsIOS on info_plus.IosDeviceInfo {
  IOSInfo toIOSInfo() {
    return IOSInfo(systemVersion: systemVersion!);
  }
}
