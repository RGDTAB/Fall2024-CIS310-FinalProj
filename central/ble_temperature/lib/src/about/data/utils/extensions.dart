import 'package:ble_temperature/src/about/domain/entities/app_info.dart';
import 'package:package_info_plus/package_info_plus.dart' as info;

extension PackageInfoExtensions on info.PackageInfo {
  AppInfo toInfo() {
    return AppInfo(
      appName: appName,
      packageName: packageName,
      version: version,
      buildNumber: buildNumber,
    );
  }
}
