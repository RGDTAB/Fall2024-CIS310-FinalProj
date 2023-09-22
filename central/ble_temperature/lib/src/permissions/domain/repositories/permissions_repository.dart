import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/src/permissions/domain/enums/permission_platform_info.dart';
import 'package:ble_temperature/src/permissions/domain/enums/permission_status.dart';

abstract class PermissionsRepository {
  ResultFuture<bool> isBluetoothGranted();
  ResultFuture<PermissionStatus> getBluetoothStatus();
  ResultFuture<PermissionStatus> requestBluetooth();
  ResultFuture<bool> isLocationWhenInUseGranted();
  ResultFuture<PermissionStatus> getLocationWhenInUseStatus();
  ResultFuture<PermissionStatus> requestLocationWhenInUse();
  ResultFuture<bool> isServiceStatusLocationWhenInUseEnabled();
  ResultFuture<bool> isBluetoothScanGranted();
  ResultFuture<PermissionStatus> getBluetoothScanStatus();
  ResultFuture<PermissionStatus> requestBluetoothScan();
  ResultFuture<bool> isBluetoothConnectGranted();
  ResultFuture<PermissionStatus> getBluetoothConnectStatus();
  ResultFuture<PermissionStatus> requestBluetoothConnect();
  ResultFuture<void> openSystemAppSettings();
  ResultFuture<void> openSystemLocationSettings();
  ResultFuture<PermissionPlatformInfo> getPermissionPlatformInfo();
}
