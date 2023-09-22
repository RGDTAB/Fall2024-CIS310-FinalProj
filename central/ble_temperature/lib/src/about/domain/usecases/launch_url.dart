import 'package:ble_temperature/core/typedefs/typedefs.dart';
import 'package:ble_temperature/core/usecase/usecase.dart';
import 'package:ble_temperature/src/about/domain/repositories/launch_url_repositpory.dart';

class LaunchUrl extends UsecaseWithParams<void, String> {
  LaunchUrl(this._repository);

  final LaunchUrlRepository _repository;

  @override
  ResultFuture<void> call(String params) async {
    return _repository.launchUrl(params);
  }
}
