part of 'permissions_cubit.dart';

sealed class PermissionsState extends Equatable {
  const PermissionsState();

  @override
  List<Object?> get props => [];
}

class PermissionsStateLoading extends PermissionsState {
  const PermissionsStateLoading();
}

class PermissionsStateUpdate extends PermissionsState {
  const PermissionsStateUpdate({
    required this.statusScan,
    required this.statusConnect,
  });
  final PermissionStatus statusScan;
  final PermissionStatus statusConnect;
}

class PermissionsStateError extends PermissionsState {
  const PermissionsStateError();
}
