import 'package:domain/domain.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart' as pkg;

class DeviceConnectionStateAdapter {
  DeviceConnectionState fromExt(pkg.DeviceConnectionState state) {
    switch (state) {
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
}
