import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/permissions/domain/enums/permission_platform_info.dart';
import 'package:ble_temperature/src/permissions/domain/repositories/permissions_repository.dart';

class GetPermissionPlatformInfo
    extends UsecaseWithoutParams<PermissionPlatformInfo> {
  GetPermissionPlatformInfo(this._repository);
  final PermissionsRepository _repository;

  @override
  ResultFuture<PermissionPlatformInfo> call() async {
    return _repository.getPermissionPlatformInfo();
  }
}
