import 'package:data/src/core/common_interfaces.dart';
import 'package:domain/domain.dart';
import 'package:device_info_plus/device_info_plus.dart';

class IOSInfoAdapter implements Adaptable<IosDeviceInfo, IOSInfo> {
  @override
  IOSInfo from(IosDeviceInfo obj) {
    return IOSInfo(systemVersion: obj.systemVersion ?? '');
  }

  @override
  IosDeviceInfo to(IOSInfo obj) {
    // TODO: implement to
    throw UnimplementedError();
  }
}
