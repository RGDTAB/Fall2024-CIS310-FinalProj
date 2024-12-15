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
  const LiveStateUpdate({required this.data});
  final Datablock data;

  @override
  List<Object?> get props => [data];
}

class LiveStateError extends LiveState {
  const LiveStateError();
}
