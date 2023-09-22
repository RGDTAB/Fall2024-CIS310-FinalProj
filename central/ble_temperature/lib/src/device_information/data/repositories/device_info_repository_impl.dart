import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/src/device_information/data/datasources/device_info_local_datasource.dart';
import 'package:ble_temperature/src/device_information/domain/entities/android_info.dart';
import 'package:ble_temperature/src/device_information/domain/entities/ios_info.dart';
import 'package:ble_temperature/src/device_information/domain/errors/failures.dart';
import 'package:ble_temperature/src/device_information/domain/repositories/device_info_repository.dart';
import 'package:dartz/dartz.dart';

class DeviceInfoRepositoryImpl implements DeviceInfoRepository {
  DeviceInfoRepositoryImpl(this._dataSource);
  final DeviceInfoLocalDataSource _dataSource;
  @override
  ResultFuture<AndroidInfo> getAndroidInfo() async {
    try {
      final result = await _dataSource.getAndroidInfo();
      return right(result);
    } on Exception catch (e) {
      return left(DeviceInfoFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<IOSInfo> getIOSInfo() async {
    try {
      final result = await _dataSource.getIOSInfo();
      return right(result);
    } on Exception catch (e) {
      return left(DeviceInfoFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<DataMap> getInfo() async {
    try {
      final result = await _dataSource.getInfo();
      return right(result);
    } on Exception catch (e) {
      return left(DeviceInfoFailure(message: e.toString()));
    }
  }
}
