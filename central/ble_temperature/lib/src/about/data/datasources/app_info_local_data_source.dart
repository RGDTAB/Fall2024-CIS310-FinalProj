import 'package:ble_temperature/src/about/data/utils/extensions.dart';
import 'package:ble_temperature/src/about/domain/entities/app_info.dart';
import 'package:package_info_plus/package_info_plus.dart' as info;

abstract class AppInfoLocalDataSource {
  Future<AppInfo> getInfo();
}

class AppInfoLocalDataSourceImpl implements AppInfoLocalDataSource {
  const AppInfoLocalDataSourceImpl();

  @override
  Future<AppInfo> getInfo() async {
    final result = await info.PackageInfo.fromPlatform();
    return result.toInfo();
  }
}
