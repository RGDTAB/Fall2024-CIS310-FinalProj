import 'package:domain/domain.dart';
import 'package:package_info_plus/package_info_plus.dart' as info;

class AppInfoImpl implements AppInfoFacade {
  @override
  Future<AppInfoResult> getInfo() async {
    info.PackageInfo pkg = await info.PackageInfo.fromPlatform();
    return AppInfoResult(
        appName: pkg.appName,
        packageName: pkg.packageName,
        version: pkg.version,
        buildNumber: pkg.buildNumber);
  }
}
