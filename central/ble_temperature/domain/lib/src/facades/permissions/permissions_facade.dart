import 'permission_status.dart';

abstract class PermissionsFacade {
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
