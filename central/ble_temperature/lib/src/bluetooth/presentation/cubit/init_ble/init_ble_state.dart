part of 'init_ble_cubit.dart';

class InitBleState extends Equatable {
  final BLEState state;

  const InitBleState({
    required this.state,
  });

  @override
  List<Object?> get props => [state];
}
