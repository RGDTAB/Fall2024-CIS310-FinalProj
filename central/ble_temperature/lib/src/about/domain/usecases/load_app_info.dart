import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/about/domain/entities/app_info_result.dart';
import 'package:ble_temperature/src/about/domain/repositories/app_info_repository.dart';
import '../../../../core/typedefs/typedefs.dart';

class LoadAppInfo extends UsecaseWithoutParams<AppInfoResult> {
  final AppInfoRepository _repository;

  LoadAppInfo(this._repository);

  @override
  ResultFuture<AppInfoResult> call() async {
    return await _repository.getInfo();
  }
}
