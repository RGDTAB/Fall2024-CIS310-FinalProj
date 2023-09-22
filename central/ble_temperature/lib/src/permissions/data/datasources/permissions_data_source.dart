import 'package:ble_temperature/src/permissions/data/utils/extensions.dart';
import 'package:ble_temperature/src/permissions/domain/enums/permission_status.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:permission_handler/permission_handler.dart' as handler;

abstract class PermissionsLocalDataSource {
  Future<bool> isBluetoothGranted();
  Future<PermissionStatus> getBluetoothStatus();
  Future<PermissionStatus> requestBluetooth();
  Future<bool> isLocationWhenInUseGranted();
  Future<PermissionStatus> getLocationWhenInUseStatus();
  Future<PermissionStatus> requestLocationWhenInUse();
  Future<bool> isServiceStatusLocationWhenInUseEnabled();
  Future<bool> isBluetoothScanGranted();
  Future<PermissionStatus> getBluetoothScanStatus();
  Future<PermissionStatus> requestBluetoothScan();
  Future<bool> isBluetoothConnectGranted();
  Future<PermissionStatus> getBluetoothConnectStatus();
  Future<PermissionStatus> requestBluetoothConnect();
  Future<void> openSystemAppSettings();
  Future<void> openSystemLocationSettings();
}

class PermissionsLocaDataSourceImpl extends PermissionsLocalDataSource {
  @override
  Future<PermissionStatus> getBluetoothConnectStatus() async {
    final status = await handler.Permission.bluetoothConnect.status;
    return status.toPermissionStatus();
  }

  @override
  Future<PermissionStatus> getBluetoothScanStatus() async {
    final status = await handler.Permission.bluetoothScan.status;
    return status.toPermissionStatus();
  }

  @override
  Future<PermissionStatus> getBluetoothStatus() async {
    final status = await handler.Permission.bluetooth.status;
    return status.toPermissionStatus();
  }

  @override
  Future<PermissionStatus> getLocationWhenInUseStatus() async {
    final status = await handler.Permission.locationWhenInUse.status;
    return status.toPermissionStatus();
  }

  @override
  Future<bool> isBluetoothConnectGranted() async {
    return handler.Permission.bluetoothConnect.isGranted;
  }

  @override
  Future<bool> isBluetoothGranted() async {
    return handler.Permission.bluetooth.isGranted;
  }

  @override
  Future<bool> isBluetoothScanGranted() async {
    return handler.Permission.bluetoothScan.isGranted;
  }

  @override
  Future<bool> isLocationWhenInUseGranted() async {
    return handler.Permission.locationWhenInUse.isGranted;
  }

  @override
  Future<bool> isServiceStatusLocationWhenInUseEnabled() async {
    return handler.Permission.locationWhenInUse.serviceStatus.isEnabled;
  }

  @override
  Future<void> openSystemAppSettings() async {
    await handler.openAppSettings();
  }

  @override
  Future<void> openSystemLocationSettings() async {
    await geo.Geolocator.openLocationSettings();
  }

  @override
  Future<PermissionStatus> requestBluetooth() async {
    final status = await handler.Permission.bluetoothScan.request();
    return status.toPermissionStatus();
  }

  @override
  Future<PermissionStatus> requestBluetoothConnect() async {
    final status = await handler.Permission.bluetoothConnect.request();
    return status.toPermissionStatus();
  }

  @override
  Future<PermissionStatus> requestBluetoothScan() async {
    final status = await handler.Permission.bluetoothScan.request();
    return status.toPermissionStatus();
  }

  @override
  Future<PermissionStatus> requestLocationWhenInUse() async {
    final status = await handler.Permission.locationWhenInUse.request();
    return status.toPermissionStatus();
  }
}
