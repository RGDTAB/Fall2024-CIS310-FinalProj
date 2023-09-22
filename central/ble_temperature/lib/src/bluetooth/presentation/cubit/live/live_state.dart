part of 'live_cubit.dart';

sealed class LiveState extends Equatable {
  const LiveState();

  @override
  List<Object?> get props => [];
}

class LiveStateLoading extends LiveState {
  const LiveStateLoading();
}

class LiveStateUpdate extends LiveState {
  final double value;

  const LiveStateUpdate({required this.value});
}

class LiveStateError extends LiveState {
  const LiveStateError();
}
