import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/permissions/domain/repositories/permissions_repository.dart';
import '../../../../core/typedefs/typedefs.dart';

class OpenSystemAppSettings extends UsecaseWithoutParams<void> {
  final PermissionsRepository _repository;

  OpenSystemAppSettings(this._repository);

  @override
  ResultFuture<void> call() async {
    return _repository.openSystemAppSettings();
  }
}
