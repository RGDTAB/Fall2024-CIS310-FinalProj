import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/permissions/domain/repositories/permissions_repository.dart';

class OpenSystemAppSettings extends UsecaseWithoutParams<void> {
  OpenSystemAppSettings(this._repository);
  final PermissionsRepository _repository;

  @override
  ResultFuture<void> call() async {
    return _repository.openSystemAppSettings();
  }
}
