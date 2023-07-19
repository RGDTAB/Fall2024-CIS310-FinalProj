import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'permissions_cubit.freezed.dart';
part 'permissions_state.dart';

class PermissionsCubit extends Cubit<PermissionsState> {
  final PermissionsFacade permissionsFacade;

  PermissionsCubit({
    required this.permissionsFacade,
  }) : super(const PermissionsState.loading());

  Future<void> update() async {
    emit(PermissionsState.update(
      statusScan: await permissionsFacade.getBluetoothScanStatus(),
      statusConnect: await permissionsFacade.getBluetoothConnectStatus(),
    ));
  }

  Future<void> requestScan() async {
    switch (state) {
      case Update():
        var status = await permissionsFacade.requestBluetoothScan();
        if (status == PermissionStatus.permanentlyDenied) {
          await permissionsFacade.openSystemAppSettings();
        }
        await update();
        break;
      default:
        break;
    }
  }

  Future<void> requestConnect() async {
    switch (state) {
      case Update():
        var status = await permissionsFacade.requestBluetoothConnect();
        if (status == PermissionStatus.permanentlyDenied) {
          await permissionsFacade.openSystemAppSettings();
        }
        await update();
        break;
      default:
        break;
    }
  }
}
