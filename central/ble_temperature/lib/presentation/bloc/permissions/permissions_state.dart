part of 'permissions_cubit.dart';

@freezed
class PermissionsState with _$PermissionsState {
  const factory PermissionsState.loading() = _Loading;

  const factory PermissionsState.update({
    required PermissionStatus statusScan,
    required PermissionStatus statusConnect,
  }) = _Update;
}
