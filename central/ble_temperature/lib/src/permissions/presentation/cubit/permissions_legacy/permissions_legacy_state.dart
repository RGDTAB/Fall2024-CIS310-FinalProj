part of 'permissions_legacy_cubit.dart';

sealed class PermissionsLegacyState extends Equatable {
  const PermissionsLegacyState();

  @override
  List<Object?> get props => [];
}

class PermissionsLegacyStateLoading extends PermissionsLegacyState {
  const PermissionsLegacyStateLoading();
}

class PermissionsLegacyStateUpdate extends PermissionsLegacyState {
  const PermissionsLegacyStateUpdate({
    required this.serviceLocationEnabled,
    required this.statusLocationWhenInUse,
  });
  final bool serviceLocationEnabled;
  final PermissionStatus statusLocationWhenInUse;

  @override
  List<Object?> get props => [serviceLocationEnabled, statusLocationWhenInUse];
}

class PermissionsLegacyStateError extends PermissionsLegacyState {
  const PermissionsLegacyStateError();
}
