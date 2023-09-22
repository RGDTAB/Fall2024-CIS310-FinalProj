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
  final PermissionStatus statusScan;
  final PermissionStatus statusConnect;

  const PermissionsStateUpdate(
      {required this.statusScan, required this.statusConnect});
}
