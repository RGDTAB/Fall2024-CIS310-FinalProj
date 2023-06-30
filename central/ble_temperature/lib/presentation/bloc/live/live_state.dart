part of 'live_cubit.dart';

@freezed
class LiveState with _$LiveState {
  const factory LiveState.loading() = _Loading;
  const factory LiveState.update({required double value}) = _Update;
  const factory LiveState.error() = _Error;
}
