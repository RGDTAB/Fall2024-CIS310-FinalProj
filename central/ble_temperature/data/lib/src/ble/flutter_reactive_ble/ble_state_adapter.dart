import 'package:domain/domain.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart' as pkg;

import '../../core/common_interfaces.dart';

class BLEStateAdapter implements Adaptable<pkg.BleStatus, BLEState> {
  @override
  BLEState from(pkg.BleStatus obj) {
    switch (obj) {
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

  @override
  pkg.BleStatus to(BLEState obj) {
    // TODO: implement to
    throw UnimplementedError();
  }
}
