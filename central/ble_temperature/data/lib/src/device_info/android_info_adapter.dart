import 'package:data/src/core/common_interfaces.dart';
import 'package:domain/domain.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AndroidInfoAdapter implements Adaptable<AndroidDeviceInfo, AndroidInfo> {
  @override
  AndroidInfo from(AndroidDeviceInfo obj) {
    return AndroidInfo(sdkInt: obj.version.sdkInt);
  }

  @override
  AndroidDeviceInfo to(AndroidInfo obj) {
    // TODO: implement to
    throw UnimplementedError();
  }
}
