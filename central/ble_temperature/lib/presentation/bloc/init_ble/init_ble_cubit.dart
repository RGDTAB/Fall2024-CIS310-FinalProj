import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'init_ble_cubit.freezed.dart';
part 'init_ble_state.dart';

class InitBleCubit extends Cubit<InitBleState> {
  final BleFacade bleFacade;
  StreamSubscription<BLEState>? _sub;

  InitBleCubit({required this.bleFacade})
      : super(const InitBleState(state: BLEState.unknown));

  void init() async {
    _sub = bleFacade.bleStateStream().listen((event) async {
      emit(InitBleState(state: event));
    });
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    await super.close();
  }
}
