import 'package:ble_temperature/src/about/data/utils/extensions.dart';
import 'package:ble_temperature/src/about/domain/entities/app_info_result.dart';
import 'package:package_info_plus/package_info_plus.dart' as info;

abstract class AppInfoLocalDataSource {
  Future<AppInfoResult> getInfo();
}

class AppInfoLocalDataSourceImpl implements AppInfoLocalDataSource {
  @override
  Future<AppInfoResult> getInfo() async {
    final result = await info.PackageInfo.fromPlatform();
    return result.toInfo();
  }
}
