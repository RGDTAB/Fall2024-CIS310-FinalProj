import 'dart:async';

import 'package:ble_temperature/src/permissions/domain/enums/permission_status.dart';
import 'package:ble_temperature/src/permissions/domain/usecases/get_location_when_in_use_status.dart';
import 'package:ble_temperature/src/permissions/domain/usecases/is_service_status_location_when_in_use_enabled.dart';
import 'package:ble_temperature/src/permissions/domain/usecases/open_system_app_settings.dart';
import 'package:ble_temperature/src/permissions/domain/usecases/request_location_when_in_use.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'permissions_legacy_state.dart';

class PermissionsLegacyCubit extends Cubit<PermissionsLegacyState> {
  final IsServiceStatusLocationWhenInUseEnabled
      _isServiceStatusLocationWhenInUseEnabled;

  final GetLocationWhenInUseStatus _getLocationWhenInUseStatus;

  final OpenSystemAppSettings _openSystemAppSettings;

  final RequestLocationWhenInUse _requestLocationWhenInUse;

  PermissionsLegacyCubit({
    required IsServiceStatusLocationWhenInUseEnabled
        isServiceStatusLocationWhenInUseEnabled,
    required GetLocationWhenInUseStatus getLocationWhenInUseStatus,
    required OpenSystemAppSettings openSystemAppSettings,
    required RequestLocationWhenInUse requestLocationWhenInUse,
  })  : _isServiceStatusLocationWhenInUseEnabled =
            isServiceStatusLocationWhenInUseEnabled,
        _getLocationWhenInUseStatus = getLocationWhenInUseStatus,
        _openSystemAppSettings = openSystemAppSettings,
        _requestLocationWhenInUse = requestLocationWhenInUse,
        super(const PermissionsLegacyStateLoading());

  Future<void> update() async {
    final isServiceStatusLocationWhenInUseEnabledResult =
        await _isServiceStatusLocationWhenInUseEnabled();
    final getLocationWhenInUseStatusResult =
        await _getLocationWhenInUseStatus();

    if (isServiceStatusLocationWhenInUseEnabledResult.isLeft() ||
        getLocationWhenInUseStatusResult.isLeft()) {
      // TODO: error
      // emit(state);
    } else {
      emit(PermissionsLegacyStateUpdate(
        serviceLocationEnabled: isServiceStatusLocationWhenInUseEnabledResult
            .getOrElse(() => false),
        statusLocationWhenInUse: getLocationWhenInUseStatusResult
            .getOrElse(() => PermissionStatus.denied),
      ));
    }
  }

  Future<void> requestLocation() async {
    switch (state) {
      case PermissionsLegacyStateUpdate():
        final _ = await _requestLocationWhenInUse();
        await update();
        break;
      default:
        break;
    }
  }

  Future<void> requestLocationService() async {
    switch (state) {
      case PermissionsLegacyStateUpdate():
        final _ = await _openSystemAppSettings();
        break;
      default:
        break;
    }
  }
}
