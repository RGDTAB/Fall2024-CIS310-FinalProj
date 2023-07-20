import 'package:flutter_reactive_ble/flutter_reactive_ble.dart' as pkg;

import '../../core/common_interfaces.dart';

class UUIDAdapter implements Adaptable<pkg.Uuid, String> {
  @override
  String from(pkg.Uuid obj) {
    return obj.toString();
  }

  @override
  pkg.Uuid to(String obj) {
    return pkg.Uuid.parse(obj);
  }
}
