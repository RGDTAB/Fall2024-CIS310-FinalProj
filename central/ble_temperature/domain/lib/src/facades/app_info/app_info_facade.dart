import 'app_info_result.dart';

abstract class AppInfoFacade {
  Future<AppInfoResult> getInfo();
}
