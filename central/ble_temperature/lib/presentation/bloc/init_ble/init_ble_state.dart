part of 'init_ble_cubit.dart';

@freezed
class InitBleState with _$InitBleState {
  const factory InitBleState({
    required BLEState state,
  }) = _InitBleState;
}
