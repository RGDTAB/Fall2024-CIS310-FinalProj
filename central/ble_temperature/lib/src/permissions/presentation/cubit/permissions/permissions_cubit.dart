import 'dart:async';
import 'package:ble_temperature/src/permissions/domain/enums/permission_status.dart';
import 'package:ble_temperature/src/permissions/domain/usecases/get_bluetooth_connect_status.dart';
import 'package:ble_temperature/src/permissions/domain/usecases/get_bluetooth_scan_status.dart';
import 'package:ble_temperature/src/permissions/domain/usecases/request_bluetooth_connect.dart';
import 'package:ble_temperature/src/permissions/domain/usecases/request_bluetooth_scan.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'permissions_state.dart';

class PermissionsCubit extends Cubit<PermissionsState> {
  final GetBluetoothScanStatus _getBluetoothScanStatus;
  final GetBluetoothConnectStatus _getBluetoothConnectStatus;
  final RequestBluetoothConnect _requestBluetoothConnect;
  final RequestBluetoothScan _requestBluetoothScan;

  PermissionsCubit({
    required GetBluetoothScanStatus getBluetoothScanStatus,
    required GetBluetoothConnectStatus getBluetoothConnectStatus,
    required RequestBluetoothConnect requestBluetoothConnect,
    required RequestBluetoothScan requestBluetoothScan,
  })  : _getBluetoothScanStatus = getBluetoothScanStatus,
        _getBluetoothConnectStatus = getBluetoothConnectStatus,
        _requestBluetoothConnect = requestBluetoothConnect,
        _requestBluetoothScan = requestBluetoothScan,
        super(const PermissionsStateLoading());

  Future<void> update() async {
    final scanStatusResult = await _getBluetoothScanStatus();
    final connectStatusResult = await _getBluetoothConnectStatus();

    if (scanStatusResult.isLeft() || connectStatusResult.isLeft()) {
      // TODO: error
      // emit(state);
    } else {
      emit(PermissionsStateUpdate(
        statusScan: scanStatusResult.getOrElse(() => PermissionStatus.denied),
        statusConnect:
            connectStatusResult.getOrElse(() => PermissionStatus.denied),
      ));
    }
  }

  Future<void> requestScan() async {
    switch (state) {
      case PermissionsStateUpdate():
        final scanResquestResult = await _requestBluetoothScan();

        scanResquestResult.fold((l) {
          // TODO: error
        }, (r) async {
          await update();
        });
        break;
      default:
        break;
    }
  }

  Future<void> requestConnect() async {
    switch (state) {
      case PermissionsStateUpdate():
        final result = await _requestBluetoothConnect();

        result.fold((l) {
          // TODO: error
        }, (r) async {
          await update();
        });

        break;
      default:
        break;
    }
  }
}
