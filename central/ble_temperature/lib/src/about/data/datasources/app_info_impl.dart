import 'package:ble_temperature/src/about/data/utils/extensions.dart';
import 'package:ble_temperature/src/about/domain/entities/app_info.dart';
import 'package:package_info_plus/package_info_plus.dart' as info;

// ignore: one_member_abstracts
abstract class AppInfoLocalDataSource {
  Future<AppInfo> getInfo();
}

class AppInfoLocalDataSourceImpl implements AppInfoLocalDataSource {
  @override
  Future<AppInfo> getInfo() async {
    final result = await info.PackageInfo.fromPlatform();
    return result.toInfo();
  }
}
