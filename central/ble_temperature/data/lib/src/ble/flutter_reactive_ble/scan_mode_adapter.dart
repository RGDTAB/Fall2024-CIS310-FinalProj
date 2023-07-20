import 'package:domain/domain.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart' as pkg;

import '../../core/common_interfaces.dart';

class ScanModeAdapter implements Adaptable<pkg.ScanMode, ScanMode> {
  @override
  ScanMode from(pkg.ScanMode obj) {
    // TODO: implement from
    throw UnimplementedError();
  }

  @override
  pkg.ScanMode to(ScanMode obj) {
    switch (obj) {
      case ScanMode.lowLatency:
        return pkg.ScanMode.lowLatency;
      case ScanMode.lowPower:
        return pkg.ScanMode.lowPower;
      case ScanMode.opportunistic:
        return pkg.ScanMode.opportunistic;
      default:
        return pkg.ScanMode.balanced;
    }
  }
}
