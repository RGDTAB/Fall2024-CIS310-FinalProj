import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/permissions/domain/repositories/permissions_repository.dart';

class IsServiceStatusLocationWhenInUseEnabled
    extends UsecaseWithoutParams<bool> {
  IsServiceStatusLocationWhenInUseEnabled(this._repository);
  final PermissionsRepository _repository;

  @override
  ResultFuture<bool> call() async {
    return _repository.isServiceStatusLocationWhenInUseEnabled();
  }
}
