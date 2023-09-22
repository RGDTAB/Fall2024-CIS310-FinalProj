import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/permissions/domain/repositories/permissions_repository.dart';
import '../../../../core/typedefs/typedefs.dart';

class IsServiceStatusLocationWhenInUseEnabled
    extends UsecaseWithoutParams<bool> {
  final PermissionsRepository _repository;

  IsServiceStatusLocationWhenInUseEnabled(this._repository);

  @override
  ResultFuture<bool> call() async {
    return _repository.isServiceStatusLocationWhenInUseEnabled();
  }
}
