import 'config/app_flavor.dart';
import 'globals.dart';
import 'main_common.dart';

void main() async {
  appFlavor = AppFlavor.prod;
  await mainCommon();
}
