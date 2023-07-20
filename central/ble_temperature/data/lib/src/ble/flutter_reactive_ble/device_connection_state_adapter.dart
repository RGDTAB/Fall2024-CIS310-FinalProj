import 'package:domain/domain.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart' as pkg;

import '../../core/common_interfaces.dart';

class DeviceConnectionStateAdapter
    implements Adaptable<pkg.DeviceConnectionState, DeviceConnectionState> {
  @override
  DeviceConnectionState from(pkg.DeviceConnectionState obj) {
    switch (obj) {
      case pkg.DeviceConnectionState.connecting:
        return DeviceConnectionState.connecting;
      case pkg.DeviceConnectionState.connected:
        return DeviceConnectionState.connected;
      case pkg.DeviceConnectionState.disconnecting:
        return DeviceConnectionState.disconnecting;
      default:
        return DeviceConnectionState.disconnected;
    }
  }

  @override
  pkg.DeviceConnectionState to(DeviceConnectionState obj) {
    // TODO: implement to
    throw UnimplementedError();
  }
}
