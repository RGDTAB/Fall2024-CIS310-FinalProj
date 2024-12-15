import 'dart:async';

import 'package:ble_temperature/src/bluetooth/data/utils/datablock.dart';
import 'package:ble_temperature/src/bluetooth/domain/enums/enums.dart';
import 'package:ble_temperature/src/bluetooth/domain/usecases/connect.dart';
import 'package:ble_temperature/src/bluetooth/domain/usecases/listen_data.dart';
import 'package:ble_temperature/src/bluetooth/domain/value_objects/device_connection_state_update.dart';
import 'package:ble_temperature/src/bluetooth/domain/value_objects/discovered_device.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'live_state.dart';

class LiveCubit extends Cubit<LiveState> {
  LiveCubit({required Connect connect, required ListenData listenData})
      : _connect = connect,
        _listenData = listenData,
        super(const LiveStateLoading());
  DiscoveredDevice? device;

  final Connect _connect;
  final ListenData _listenData;

  StreamSubscription<DeviceConnectionStateUpdate>? _connectionSub;
  StreamSubscription<Datablock>? _valueSub;

  Future<void> init(DiscoveredDevice device) async {
    switch (state) {
      case LiveStateLoading():
        _connectionSub = _connect(
          ConnectParams(
            deviceId: device.id,
            timeout: const Duration(seconds: 5),
          ),
        ).listen((event) {
          switch (event.deviceConnectionState) {
            case DeviceConnectionState.connected:
              _onConnected(event);
            case DeviceConnectionState.disconnected:
              if (event.error != null) {
                emit(const LiveStateError());
              }
            case DeviceConnectionState.disconnecting:
            case DeviceConnectionState.connecting:
          }
        });

      default:
        break;
    }
  }

  Future<void> _onConnected(DeviceConnectionStateUpdate update) async {
    _valueSub = _listenData(
      update.deviceId,
    ).listen((event) {
      emit(
        LiveStateUpdate(
          data: event,
        ),
      );
    });
  }

  Future<void> retry(DiscoveredDevice device) async {
    switch (state) {
      case Error():
        await _valueSub?.cancel();
        await _connectionSub?.cancel();
        emit(const LiveStateLoading());
        await init(device);
      default:
        break;
    }
  }

  @override
  Future<void> close() async {
    await _valueSub?.cancel();
    await _connectionSub?.cancel();
    await super.close();
  }
}
