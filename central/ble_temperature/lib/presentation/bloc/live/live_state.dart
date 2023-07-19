part of 'live_cubit.dart';

@freezed
sealed class LiveState with _$LiveState {
  const factory LiveState.loading() = Loading;
  const factory LiveState.update({required double value}) = Update;
  const factory LiveState.error() = Error;
}
