import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/permissions/domain/enums/permission_status.dart';
import 'package:ble_temperature/src/permissions/domain/repositories/permissions_repository.dart';

class RequestBluetoothScan extends UsecaseWithoutParams<PermissionStatus> {
  RequestBluetoothScan(this._repository);
  final PermissionsRepository _repository;

  @override
  ResultFuture<PermissionStatus> call() async {
    final result = await _repository.requestBluetoothScan();

    return result.fold((l) => result, (r) {
      if (r == PermissionStatus.permanentlyDenied) {
        _repository.openSystemAppSettings();
      }
      return result;
    });
  }
}
