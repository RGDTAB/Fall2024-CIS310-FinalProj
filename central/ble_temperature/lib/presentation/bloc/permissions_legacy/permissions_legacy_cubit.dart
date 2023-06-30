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
  }) : super(const PermissionsLegacyState.loading()) {
    update();
  }

  Future<void> update() async {
    emit(PermissionsLegacyState.update(
      serviceLocationEnabled:
          await permissionsFacade.isServiceStatusLocationWhenInUseEnabled(),
      statusLocationWhenInUse:
          await permissionsFacade.getLocationWhenInUseStatus(),
    ));
  }

  Future<void> requestLocation() async {
    state.whenOrNull(update: (_, __) async {
      var status = await permissionsFacade.requestLocationWhenInUse();
      if (status == PermissionStatus.permanentlyDenied) {
        await permissionsFacade.openSystemAppSettings();
      }

      update();
    });
  }

  Future<void> requestLocationService() async {
    state.whenOrNull(update: (_, __) async {
      await permissionsFacade.openSystemAppSettings();
    });
  }
}
