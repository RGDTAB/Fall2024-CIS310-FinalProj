import 'dart:async';

import 'package:ble_temperature/src/bluetooth/domain/enums/enums.dart';
import 'package:ble_temperature/src/bluetooth/domain/usecases/listen_ble_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'init_ble_state.dart';

class InitBleCubit extends Cubit<InitBleState> {
  InitBleCubit({required ListenBleState listenBleState})
      : _listenBleState = listenBleState,
        super(const InitBleState(state: BLEState.unknown));
  final ListenBleState _listenBleState;
  StreamSubscription<BLEState>? _sub;

  Future<void> init() async {
    _sub = _listenBleState().listen((event) async {
      emit(InitBleState(state: event));
    });
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    await super.close();
  }
}
