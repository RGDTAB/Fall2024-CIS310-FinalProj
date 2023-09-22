import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/src/about/data/datasources/app_info_impl.dart';
import 'package:ble_temperature/src/about/domain/entities/app_info_result.dart';
import 'package:ble_temperature/src/about/domain/errors/failures.dart';
import 'package:ble_temperature/src/about/domain/repositories/app_info_repository.dart';
import 'package:dartz/dartz.dart';

class AppInfoRepositoryImpl implements AppInfoRepository {
  final AppInfoLocalDataSource _localDataSource;

  AppInfoRepositoryImpl(this._localDataSource);

  @override
  ResultFuture<AppInfoResult> getInfo() async {
    try {
      final result = await _localDataSource.getInfo();
      return right(result);
    } on Exception catch (e) {
      return left(GetAppInfoFailure(message: e.toString()));
    }
  }

  // @override
  // Future<AppInfoResult> getInfo() async {

  //   return _localDataSource.;
  // }
}
