import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/permissions/domain/enums/permission_status.dart';
import 'package:ble_temperature/src/permissions/domain/repositories/permissions_repository.dart';

class GetLocationWhenInUseStatus
    extends UsecaseWithoutParams<PermissionStatus> {
  GetLocationWhenInUseStatus(this._repository);
  final PermissionsRepository _repository;

  @override
  ResultFuture<PermissionStatus> call() async {
    return _repository.getLocationWhenInUseStatus();
  }
}
