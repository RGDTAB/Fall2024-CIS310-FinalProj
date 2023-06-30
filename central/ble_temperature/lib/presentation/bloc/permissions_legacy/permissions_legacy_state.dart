part of 'permissions_legacy_cubit.dart';

@freezed
class PermissionsLegacyState with _$PermissionsLegacyState {
  const factory PermissionsLegacyState.loading() = _Loading;

  const factory PermissionsLegacyState.update({
    required bool serviceLocationEnabled,
    required PermissionStatus statusLocationWhenInUse,
  }) = _Update;
}
