import 'package:ble_temperature/src/bluetooth/domain/enums/enums.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart' as ble;

extension StringExtensions on String {
  ble.Uuid toUuid() {
    return ble.Uuid.parse(this);
  }
}

extension ScanModeBleExtensions on ble.ScanMode {
  ScanMode toScanMode() {
    switch (this) {
      case ble.ScanMode.lowLatency:
        return ScanMode.lowLatency;
      case ble.ScanMode.lowPower:
        return ScanMode.lowPower;
      case ble.ScanMode.opportunistic:
        return ScanMode.opportunistic;
      case ble.ScanMode.balanced:
        return ScanMode.balanced;
    }
  }
}

extension ScanModeExtensions on ScanMode {
  ble.ScanMode toScanBleMode() {
    switch (this) {
      case ScanMode.lowLatency:
        return ble.ScanMode.lowLatency;
      case ScanMode.lowPower:
        return ble.ScanMode.lowPower;
      case ScanMode.opportunistic:
        return ble.ScanMode.opportunistic;
      case ScanMode.balanced:
        return ble.ScanMode.balanced;
    }
  }
}

extension DeviceConnectionStateExtensions on DeviceConnectionState {
  ble.DeviceConnectionState toDeviceConnectionStateBle() {
    switch (this) {
      case DeviceConnectionState.connecting:
        return ble.DeviceConnectionState.connecting;
      case DeviceConnectionState.connected:
        return ble.DeviceConnectionState.connected;
      case DeviceConnectionState.disconnecting:
        return ble.DeviceConnectionState.disconnecting;
      case DeviceConnectionState.disconnected:
        return ble.DeviceConnectionState.disconnected;
    }
  }
}

extension DeviceConnectionStateBleExtensions on ble.DeviceConnectionState {
  DeviceConnectionState toDeviceConnectionState() {
    switch (this) {
      case ble.DeviceConnectionState.connecting:
        return DeviceConnectionState.connecting;
      case ble.DeviceConnectionState.connected:
        return DeviceConnectionState.connected;
      case ble.DeviceConnectionState.disconnecting:
        return DeviceConnectionState.disconnecting;
      case ble.DeviceConnectionState.disconnected:
        return DeviceConnectionState.disconnected;
    }
  }
}

extension BleStatusExtensions on ble.BleStatus {
  BLEState toBleStatus() {
    switch (this) {
      case ble.BleStatus.unsupported:
        return BLEState.unsupported;
      case ble.BleStatus.unauthorized:
        return BLEState.unauthorized;
      case ble.BleStatus.poweredOff:
        return BLEState.poweredOff;
      case ble.BleStatus.locationServicesDisabled:
        return BLEState.locationServicesDisabled;
      case ble.BleStatus.ready:
        return BLEState.ready;
      case ble.BleStatus.unknown:
        return BLEState.unknown;
    }
  }
}
