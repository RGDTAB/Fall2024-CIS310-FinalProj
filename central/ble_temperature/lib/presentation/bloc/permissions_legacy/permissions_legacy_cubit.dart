import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'permissions_legacy_cubit.freezed.dart';
part 'permissions_legacy_state.dart';

class PermissionsLegacyCubit extends Cubit<PermissionsLegacyState> {
  final PermissionsFacade permissionsFacade;

  PermissionsLegacyCubit({
    required this.permissionsFacade,
  }) : super(const PermissionsLegacyState.loading());

  Future<void> update() async {
    emit(PermissionsLegacyState.update(
      serviceLocationEnabled:
          await permissionsFacade.isServiceStatusLocationWhenInUseEnabled(),
      statusLocationWhenInUse:
          await permissionsFacade.getLocationWhenInUseStatus(),
    ));
  }

  Future<void> requestLocation() async {
    switch (state) {
      case Update():
        var status = await permissionsFacade.requestLocationWhenInUse();
        if (status == PermissionStatus.permanentlyDenied) {
          await permissionsFacade.openSystemAppSettings();
        }

        await update();
        break;
      default:
        break;
    }
  }

  Future<void> requestLocationService() async {
    switch (state) {
      case Update():
        await permissionsFacade.openSystemAppSettings();
        break;
      default:
        break;
    }
  }
}
