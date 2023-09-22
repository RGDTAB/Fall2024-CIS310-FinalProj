import 'dart:io' show Platform;

import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/src/device_information/data/datasources/device_info_local_datasource.dart';
import 'package:ble_temperature/src/permissions/data/datasources/permissions_data_source.dart';
import 'package:ble_temperature/src/permissions/domain/enums/permission_platform_info.dart';
import 'package:ble_temperature/src/permissions/domain/enums/permission_status.dart';
import 'package:ble_temperature/src/permissions/domain/errors/failures.dart';
import 'package:ble_temperature/src/permissions/domain/repositories/permissions_repository.dart';
import 'package:dartz/dartz.dart';

class PermissionsRepositoryImpl implements PermissionsRepository {
  final PermissionsLocalDataSource _permssionsDataSource;
  final DeviceInfoLocalDataSource _deviceInfoDataSource;

  PermissionsRepositoryImpl(
      this._permssionsDataSource, this._deviceInfoDataSource);

  @override
  ResultFuture<PermissionStatus> getBluetoothConnectStatus() async {
    try {
      final result = await _permssionsDataSource.getBluetoothConnectStatus();
      return right(result);
    } on Exception catch (e) {
      return left(PermissionFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<PermissionStatus> getBluetoothScanStatus() async {
    try {
      final result = await _permssionsDataSource.getBluetoothScanStatus();
      return right(result);
    } on Exception catch (e) {
      return left(PermissionFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<PermissionStatus> getBluetoothStatus() async {
    try {
      final result = await _permssionsDataSource.getBluetoothStatus();
      return right(result);
    } on Exception catch (e) {
      return left(PermissionFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<PermissionStatus> getLocationWhenInUseStatus() async {
    try {
      final result = await _permssionsDataSource.getLocationWhenInUseStatus();
      return right(result);
    } on Exception catch (e) {
      return left(PermissionFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<bool> isBluetoothConnectGranted() async {
    try {
      final result = await _permssionsDataSource.isBluetoothConnectGranted();
      return right(result);
    } on Exception catch (e) {
      return left(PermissionFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<bool> isBluetoothGranted() async {
    try {
      final result = await _permssionsDataSource.isBluetoothGranted();
      return right(result);
    } on Exception catch (e) {
      return left(PermissionFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<bool> isBluetoothScanGranted() async {
    try {
      final result = await _permssionsDataSource.isBluetoothScanGranted();
      return right(result);
    } on Exception catch (e) {
      return left(PermissionFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<bool> isLocationWhenInUseGranted() async {
    try {
      final result = await _permssionsDataSource.isLocationWhenInUseGranted();
      return right(result);
    } on Exception catch (e) {
      return left(PermissionFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<bool> isServiceStatusLocationWhenInUseEnabled() async {
    try {
      final result =
          await _permssionsDataSource.isServiceStatusLocationWhenInUseEnabled();
      return right(result);
    } on Exception catch (e) {
      return left(PermissionFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<void> openSystemAppSettings() async {
    try {
      await _permssionsDataSource.openSystemAppSettings();
      return right(null);
    } on Exception catch (e) {
      return left(PermissionFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<void> openSystemLocationSettings() async {
    try {
      await _permssionsDataSource.openSystemLocationSettings();
      return right(null);
    } on Exception catch (e) {
      return left(PermissionFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<PermissionStatus> requestBluetooth() async {
    try {
      final result = await _permssionsDataSource.requestBluetooth();
      return right(result);
    } on Exception catch (e) {
      return left(PermissionFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<PermissionStatus> requestBluetoothConnect() async {
    try {
      final result = await _permssionsDataSource.requestBluetoothConnect();
      return right(result);
    } on Exception catch (e) {
      return left(PermissionFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<PermissionStatus> requestBluetoothScan() async {
    try {
      final result = await _permssionsDataSource.requestBluetoothScan();
      return right(result);
    } on Exception catch (e) {
      return left(PermissionFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<PermissionStatus> requestLocationWhenInUse() async {
    try {
      final result = await _permssionsDataSource.requestLocationWhenInUse();
      return right(result);
    } on Exception catch (e) {
      return left(PermissionFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<PermissionPlatformInfo> getPermissionPlatformInfo() async {
    if (Platform.isIOS) {
      return right(PermissionPlatformInfo.granted);
    } else {
      final info = await _deviceInfoDataSource.getAndroidInfo();

      final isLegacy = info.sdkInt < 31;

      if (isLegacy) {
        final p1 = await _permssionsDataSource
            .isServiceStatusLocationWhenInUseEnabled();
        final p2 = await _permssionsDataSource.getLocationWhenInUseStatus() ==
            PermissionStatus.granted;

        if (p1 && p2) {
          return right(PermissionPlatformInfo.granted);
        } else {
          return right(PermissionPlatformInfo.legacyNotGranted);
        }
      } else {
        final p1 = await _permssionsDataSource.getBluetoothScanStatus() ==
            PermissionStatus.granted;
        final p2 = await _permssionsDataSource.getBluetoothConnectStatus() ==
            PermissionStatus.granted;

        if (p1 && p2) {
          return right(PermissionPlatformInfo.granted);
        } else {
          return right(PermissionPlatformInfo.notGranted);
        }
      }
    }
  }
}
