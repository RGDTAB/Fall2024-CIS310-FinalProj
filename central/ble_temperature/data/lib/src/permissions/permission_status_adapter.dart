import 'package:domain/domain.dart';
import 'package:permission_handler/permission_handler.dart' as pkg;

class PermissionStatusAdapter {
  PermissionStatus fromExt(pkg.PermissionStatus status) {
    switch (status) {
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
}
