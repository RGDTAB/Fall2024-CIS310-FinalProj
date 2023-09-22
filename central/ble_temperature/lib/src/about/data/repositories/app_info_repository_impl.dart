import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/src/about/data/datasources/app_info_impl.dart';
import 'package:ble_temperature/src/about/domain/entities/app_info.dart';
import 'package:ble_temperature/src/about/domain/errors/failures.dart';
import 'package:ble_temperature/src/about/domain/repositories/app_info_repository.dart';
import 'package:dartz/dartz.dart';

class AppInfoRepositoryImpl implements AppInfoRepository {
  AppInfoRepositoryImpl(this._localDataSource);
  final AppInfoLocalDataSource _localDataSource;

  @override
  ResultFuture<AppInfo> getInfo() async {
    try {
      final result = await _localDataSource.getInfo();
      return right(result);
    } on Exception catch (e) {
      return left(GetAppInfoFailure(message: e.toString()));
    }
  }
}
