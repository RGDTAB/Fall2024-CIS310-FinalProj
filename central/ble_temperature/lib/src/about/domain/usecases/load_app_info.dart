import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/about/domain/entities/app_info.dart';
import 'package:ble_temperature/src/about/domain/repositories/app_info_repository.dart';

class LoadAppInfo extends UsecaseWithoutParams<AppInfo> {
  LoadAppInfo(this._repository);
  final AppInfoRepository _repository;

  @override
  ResultFuture<AppInfo> call() async {
    return _repository.getInfo();
  }
}
