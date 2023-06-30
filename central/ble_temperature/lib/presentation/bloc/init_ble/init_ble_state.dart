part of 'init_ble_cubit.dart';

@freezed
class InitBleState with _$InitBleState {
  const factory InitBleState.update({
    required BLEState state,
  }) = _Update;
}
