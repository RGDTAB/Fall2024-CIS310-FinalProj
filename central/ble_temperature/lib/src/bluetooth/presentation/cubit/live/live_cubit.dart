import 'dart:async';
import 'dart:convert';

import 'package:ble_temperature/core/app_ble.dart';
import 'package:ble_temperature/src/bluetooth/domain/entities/device_connection_state_update.dart';
import 'package:ble_temperature/src/bluetooth/domain/entities/discovered_device.dart';
import 'package:ble_temperature/src/bluetooth/domain/enums/enums.dart';
import 'package:ble_temperature/src/bluetooth/domain/usecases/connect.dart';
import 'package:ble_temperature/src/bluetooth/domain/usecases/listen_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'live_state.dart';

class LiveCubit extends Cubit<LiveState> {
  DiscoveredDevice? device;

  final Connect _connect;
  final ListenData _listenData;

  StreamSubscription<DeviceConnectionStateUpdate>? _connectionSub;
  StreamSubscription<List<int>>? _valueSub;

  LiveCubit({required Connect connect, required ListenData listenData})
      : _connect = connect,
        _listenData = listenData,
        super(const LiveStateLoading());

  Future<void> init(DiscoveredDevice device) async {
    switch (state) {
      case LiveStateLoading():
        _connectionSub = _connect(ConnectParams(
                deviceId: device.id, timeout: const Duration(seconds: 5)))
            .listen((event) {
          switch (event.deviceConnectionState) {
            case DeviceConnectionState.connected:
              _onConnected(event);
              break;
            case DeviceConnectionState.disconnected:
              if (event.error != null) {
                emit(const LiveStateError());
              }
              break;
            default:
          }
        });

        break;
      default:
        break;
    }
  }

  void _onConnected(DeviceConnectionStateUpdate update) async {
    _valueSub = _listenData(ListenDataParams(
            deviceId: update.deviceId,
            serviceUuid: AppBle.srvUuid,
            characteristicUuid: AppBle.chrUuid))
        .listen((event) {
      emit(LiveStateUpdate(
          value: double.tryParse(const Utf8Decoder().convert(event)) ?? 0.0));
    });
  }

  Future<void> retry(DiscoveredDevice device) async {
    switch (state) {
      case Error():
        await _valueSub?.cancel();
        await _connectionSub?.cancel();
        emit(const LiveStateLoading());
        await init(device);
        break;
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
