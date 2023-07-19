part of 'permissions_legacy_cubit.dart';

@freezed
sealed class PermissionsLegacyState with _$PermissionsLegacyState {
  const factory PermissionsLegacyState.loading() = Loading;

  const factory PermissionsLegacyState.update({
    required bool serviceLocationEnabled,
    required PermissionStatus statusLocationWhenInUse,
  }) = Update;
}
