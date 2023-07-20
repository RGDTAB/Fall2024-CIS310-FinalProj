import 'package:domain/domain.dart';
import 'package:permission_handler/permission_handler.dart' as pkg;

import '../core/common_interfaces.dart';

class PermissionStatusAdapter
    implements Adaptable<pkg.PermissionStatus, PermissionStatus> {
  @override
  PermissionStatus from(pkg.PermissionStatus obj) {
    switch (obj) {
      case pkg.PermissionStatus.denied:
        return PermissionStatus.denied;
      case pkg.PermissionStatus.granted:
        return PermissionStatus.granted;
      case pkg.PermissionStatus.limited:
        return PermissionStatus.limited;
      case pkg.PermissionStatus.restricted:
        return PermissionStatus.restricted;
      default:
        return PermissionStatus.permanentlyDenied;
    }
  }

  @override
  pkg.PermissionStatus to(PermissionStatus obj) {
    // TODO: implement to
    throw UnimplementedError();
  }
}
