import 'package:ble_temperature/src/about/domain/entities/app_info_result.dart';
import 'package:package_info_plus/package_info_plus.dart' as info;

extension PackageInfoExtensions on info.PackageInfo {
  AppInfoResult toInfo() {
    return AppInfoResult(
        appName: appName,
        packageName: packageName,
        version: version,
        buildNumber: buildNumber);
  }
}
