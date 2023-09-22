import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/permissions/domain/enums/permission_platform_info.dart';
import 'package:ble_temperature/src/permissions/domain/repositories/permissions_repository.dart';
import '../../../../core/typedefs/typedefs.dart';

class GetPermissionPlatformInfo
    extends UsecaseWithoutParams<PermissionPlatformInfo> {
  final PermissionsRepository _repository;

  GetPermissionPlatformInfo(this._repository);

  @override
  ResultFuture<PermissionPlatformInfo> call() async {
    return _repository.getPermissionPlatformInfo();
  }
}
