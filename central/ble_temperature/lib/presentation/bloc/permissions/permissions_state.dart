part of 'permissions_cubit.dart';

@freezed
sealed class PermissionsState with _$PermissionsState {
  const factory PermissionsState.loading() = Loading;

  const factory PermissionsState.update({
    required PermissionStatus statusScan,
    required PermissionStatus statusConnect,
  }) = Update;
}
