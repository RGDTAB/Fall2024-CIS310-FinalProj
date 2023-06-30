import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../config/app_ble.dart';

part 'live_cubit.freezed.dart';
part 'live_state.dart';

class LiveCubit extends Cubit<LiveState> {
  final DiscoveredDevice device;
  final BleConnect ucConnect;
  final BleGetData ucGetData;

  StreamSubscription<DeviceConnectionStateUpdate>? _connectionSub;
  StreamSubscription<double>? _valueSub;

  LiveCubit(
      {required this.device, required this.ucConnect, required this.ucGetData})
      : super(const LiveState.loading());

  void init() {
    state.whenOrNull(
      loading: () async {
        final result = await ucConnect(BleConnectParams(id: device.id));
        result.fold((l) => null, (r) {
          _connectionSub = r.listen((event) {
            switch (event.deviceConnectionState) {
              case DeviceConnectionState.connected:
                _onConnected(event);
                break;
              case DeviceConnectionState.disconnected:
                if (event.error != null) {
                  emit(const LiveState.error());
                }
                break;
              default:
            }
          });
        });
      },
    );
  }

  void _onConnected(DeviceConnectionStateUpdate update) async {
    final result = await ucGetData(BleGetDataParams(
        deviceId: update.deviceId,
        serviceUuid: AppBle.srvUuid,
        characteristicUuid: AppBle.chrUuid));

    result.fold((l) => null, (r) {
      _valueSub = r.listen((event) {
        emit(LiveState.update(value: event));
      }, onError: (e) {
        emit(const LiveState.error());
      }, cancelOnError: true);
    });
  }

  void retry() {
    state.whenOrNull(error: () async {
      await _valueSub?.cancel();
      await _connectionSub?.cancel();
      emit(const LiveState.loading());
      init();
    });
  }

  @override
  Future<void> close() async {
    await _valueSub?.cancel();
    await _connectionSub?.cancel();
    await super.close();
  }
}
