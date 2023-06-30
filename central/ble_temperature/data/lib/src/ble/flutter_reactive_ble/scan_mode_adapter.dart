import 'package:domain/domain.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart' as pkg;

class ScanModeAdapter {
  pkg.ScanMode toExt(ScanMode scanMode) {
    switch (scanMode) {
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
