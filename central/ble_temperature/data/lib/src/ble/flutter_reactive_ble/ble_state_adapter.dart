import 'package:domain/domain.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart' as pkg;

class BLEStateAdapter {
  BLEState fromExt(pkg.BleStatus state) {
    switch (state) {
      case pkg.BleStatus.unsupported:
        return BLEState.unsupported;
      case pkg.BleStatus.unauthorized:
        return BLEState.unauthorized;
      case pkg.BleStatus.poweredOff:
        return BLEState.poweredOff;
      case pkg.BleStatus.locationServicesDisabled:
        return BLEState.locationServicesDisabled;
      case pkg.BleStatus.ready:
        return BLEState.ready;
      default:
        return BLEState.unknown;
    }
  }
}
