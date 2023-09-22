import 'package:ble_temperature/core/app_flavor.dart';

import 'core/globals.dart';
import 'main_common.dart';

void main() async {
  appFlavor = AppFlavor.sim;
  await mainCommon();
}
