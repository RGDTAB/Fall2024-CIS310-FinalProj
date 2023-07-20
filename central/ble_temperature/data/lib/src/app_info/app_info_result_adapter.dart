import 'package:data/src/core/common_interfaces.dart';
import 'package:domain/domain.dart';
import 'package:package_info_plus/package_info_plus.dart' as info;

class AppInfoResultAdapter
    implements Adaptable<info.PackageInfo, AppInfoResult> {
  @override
  AppInfoResult from(info.PackageInfo obj) {
    return AppInfoResult(
        appName: obj.appName,
        packageName: obj.packageName,
        version: obj.version,
        buildNumber: obj.buildNumber);
  }

  @override
  info.PackageInfo to(AppInfoResult obj) {
    // TODO: implement to
    throw UnimplementedError();
  }
}
