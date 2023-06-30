import 'package:flutter_reactive_ble/flutter_reactive_ble.dart' as pkg;

class UUIDAdapter {
  String fromExt(pkg.Uuid uuid) {
    return uuid.toString();
  }

  pkg.Uuid toExt(String uuid) {
    return pkg.Uuid.parse(uuid);
  }
}
