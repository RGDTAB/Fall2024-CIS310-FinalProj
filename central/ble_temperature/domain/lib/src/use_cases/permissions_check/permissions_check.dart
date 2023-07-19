import 'dart:io' show Platform;

import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/use_case/common_interfaces.dart';
import '../../core/use_case/use_case.dart';
import '../../facades/device_info/device_info_facade.dart';
import '../../facades/permissions/permission_status.dart';
import '../../facades/permissions/permissions_facade.dart';

part 'permissions_check.freezed.dart';

class PermissionsCheck
    implements UseCase<NoFailure, PermissionsCheckResult, NoParams> {
  final DeviceInfoFacade _deviceInfoFacade;
  final PermissionsFacade _permissionsFacade;

  PermissionsCheck(this._deviceInfoFacade, this._permissionsFacade);

  @override
  Future<Either<NoFailure, PermissionsCheckResult>> call(
      NoParams params) async {
    if (Platform.isIOS) {
      return right(PermissionsCheckResult(hasAllPermissions: true));
    } else {
      final result = <bool>[];
      final info = await _deviceInfoFacade.getAndroidInfo();

      final bool isLegacy = info.sdkInt < 31;

      if (isLegacy) {
        result.addAll([
          await _permissionsFacade.isServiceStatusLocationWhenInUseEnabled(),
          await _permissionsFacade.getLocationWhenInUseStatus() ==
              PermissionStatus.granted,
        ]);
      } else {
        result.addAll([
          await _permissionsFacade.getBluetoothScanStatus() ==
              PermissionStatus.granted,
          await _permissionsFacade.getBluetoothConnectStatus() ==
              PermissionStatus.granted,
        ]);
      }

      return right(PermissionsCheckResult(
          hasAllPermissions: result.every((element) => element),
          isLegacy: isLegacy));
    }
  }
}

@freezed
class PermissionsCheckResult with _$PermissionsCheckResult {
  factory PermissionsCheckResult({
    required bool hasAllPermissions,
    bool? isLegacy,
  }) = _PermissionsCheckResult;
}
