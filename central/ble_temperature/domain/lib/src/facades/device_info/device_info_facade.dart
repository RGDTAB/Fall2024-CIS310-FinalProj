import 'android_info.dart';
import 'ios_info.dart';

abstract class DeviceInfoFacade {
  Future<AndroidInfo> getAndroidInfo();
  Future<IOSInfo> getIOSInfo();
  Future<Map<String, dynamic>> getInfo();
}
