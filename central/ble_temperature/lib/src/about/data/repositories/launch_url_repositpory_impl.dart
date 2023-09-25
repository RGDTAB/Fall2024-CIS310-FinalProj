import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/src/about/data/datasources/launch_url_local_data_source.dart';
import 'package:ble_temperature/src/about/domain/errors/failures.dart';
import 'package:ble_temperature/src/about/domain/repositories/launch_url_repositpory.dart';
import 'package:dartz/dartz.dart';

class LaunchUrlRepositoryImpl implements LaunchUrlRepository {
  LaunchUrlRepositoryImpl(this._localDataSource);
  final LaunchUrlLocalDataSource _localDataSource;

  @override
  ResultFuture<void> launchUrl(String url) async {
    try {
      final result = await _localDataSource.launchUrl(url);

      if (!result) {
        return right(null);
      }

      throw Exception('Unexpected error.');
    } on Exception catch (e) {
      return left(LaunchUrlFailure(message: e.toString()));
    }
  }
}
