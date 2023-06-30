import 'package:domain/domain.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:permission_handler/permission_handler.dart' as handler;

import 'permission_status_adapter.dart';

class PermissionsFacadeImpl implements PermissionsFacade {
  @override
  Future<bool> isBluetoothGranted() async {
    return await handler.Permission.bluetooth.isGranted;
  }

  @override
  Future<PermissionStatus> getBluetoothStatus() async {
    handler.PermissionStatus status = await handler.Permission.bluetooth.status;
    return PermissionStatusAdapter().fromExt(status);
  }

  @override
  Future<PermissionStatus> requestBluetooth() async {
    handler.PermissionStatus status =
        await handler.Permission.bluetooth.request();
    return PermissionStatusAdapter().fromExt(status);
  }

  @override
  Future<bool> isLocationWhenInUseGranted() async {
    return await handler.Permission.locationWhenInUse.isGranted;
  }

  @override
  Future<PermissionStatus> getLocationWhenInUseStatus() async {
    handler.PermissionStatus status =
        await handler.Permission.locationWhenInUse.status;
    return PermissionStatusAdapter().fromExt(status);
  }

  @override
  Future<PermissionStatus> requestLocationWhenInUse() async {
    handler.PermissionStatus status =
        await handler.Permission.locationWhenInUse.request();
    return PermissionStatusAdapter().fromExt(status);
  }

  @override
  Future<bool> isServiceStatusLocationWhenInUseEnabled() async {
    return await handler.Permission.locationWhenInUse.serviceStatus.isEnabled;
  }

  @override
  Future<bool> isBluetoothScanGranted() async {
    return await handler.Permission.bluetoothScan.isGranted;
  }

  @override
  Future<PermissionStatus> getBluetoothScanStatus() async {
    handler.PermissionStatus status =
        await handler.Permission.bluetoothScan.status;
    return PermissionStatusAdapter().fromExt(status);
  }

  @override
  Future<PermissionStatus> requestBluetoothScan() async {
    handler.PermissionStatus status =
        await handler.Permission.bluetoothScan.request();
    return PermissionStatusAdapter().fromExt(status);
  }

  @override
  Future<bool> isBluetoothConnectGranted() async {
    return await handler.Permission.bluetoothConnect.isGranted;
  }

  @override
  Future<PermissionStatus> getBluetoothConnectStatus() async {
    handler.PermissionStatus status =
        await handler.Permission.bluetoothConnect.status;
    return PermissionStatusAdapter().fromExt(status);
  }

  @override
  Future<PermissionStatus> requestBluetoothConnect() async {
    handler.PermissionStatus status =
        await handler.Permission.bluetoothConnect.request();
    return PermissionStatusAdapter().fromExt(status);
  }

  @override
  Future<void> openSystemAppSettings() async {
    await handler.openAppSettings();
  }

  @override
  Future<void> openSystemLocationSettings() async {
    await geo.Geolocator.openLocationSettings();
  }
}
