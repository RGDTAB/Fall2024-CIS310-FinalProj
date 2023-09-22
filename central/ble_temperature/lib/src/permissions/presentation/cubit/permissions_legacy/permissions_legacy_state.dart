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
  final bool serviceLocationEnabled;
  final PermissionStatus statusLocationWhenInUse;

  const PermissionsLegacyStateUpdate({
    required this.serviceLocationEnabled,
    required this.statusLocationWhenInUse,
  });

  @override
  List<Object?> get props => [serviceLocationEnabled, statusLocationWhenInUse];
}
