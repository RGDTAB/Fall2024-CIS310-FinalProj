import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/permissions/domain/enums/permission_status.dart';
import 'package:ble_temperature/src/permissions/domain/repositories/permissions_repository.dart';
import '../../../../core/typedefs/typedefs.dart';

class RequestBluetoothConnect extends UsecaseWithoutParams<PermissionStatus> {
  final PermissionsRepository _repository;

  RequestBluetoothConnect(this._repository);

  @override
  ResultFuture<PermissionStatus> call() async {
    final result = await _repository.requestBluetoothConnect();

    return result.fold((l) => result, (r) {
      if (r == PermissionStatus.permanentlyDenied) {
        _repository.openSystemAppSettings();
      }
      return result;
    });
  }
}
