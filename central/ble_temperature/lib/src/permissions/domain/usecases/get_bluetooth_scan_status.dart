import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/permissions/domain/enums/permission_status.dart';
import 'package:ble_temperature/src/permissions/domain/repositories/permissions_repository.dart';
import '../../../../core/typedefs/typedefs.dart';

class GetBluetoothScanStatus extends UsecaseWithoutParams<PermissionStatus> {
  final PermissionsRepository _repository;

  GetBluetoothScanStatus(this._repository);

  @override
  ResultFuture<PermissionStatus> call() async {
    return _repository.getBluetoothScanStatus();
  }
}
