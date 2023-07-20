import 'package:data/src/app_info/app_info_result_adapter.dart';
import 'package:domain/domain.dart';
import 'package:package_info_plus/package_info_plus.dart' as info;

class AppInfoImpl implements AppInfoFacade {
  @override
  Future<AppInfoResult> getInfo() async {
    return AppInfoResultAdapter().from(await info.PackageInfo.fromPlatform());
  }
}
