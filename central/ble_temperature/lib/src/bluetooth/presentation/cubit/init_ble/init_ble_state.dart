part of 'init_ble_cubit.dart';

class InitBleState extends Equatable {
  const InitBleState({
    required this.state,
  });
  final BLEState state;

  @override
  List<Object?> get props => [state];
}
