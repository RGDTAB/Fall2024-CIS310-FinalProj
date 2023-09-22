import 'package:ble_temperature/core/app_globals.dart';
import 'package:ble_temperature/core/enums/app_flavor.dart';

import 'package:ble_temperature/main_common.dart';

void main() async {
  appFlavor = AppFlavor.prod;
  await mainCommon();
}
