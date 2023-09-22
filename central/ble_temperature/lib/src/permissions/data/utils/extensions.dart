import 'package:ble_temperature/src/permissions/domain/enums/permission_status.dart';
import 'package:permission_handler/permission_handler.dart' as handler;

extension PermissionHandlerStatusExtensions on handler.PermissionStatus {
  PermissionStatus toPermissionStatus() {
    switch (this) {
      case handler.PermissionStatus.denied:
        return PermissionStatus.denied;
      case handler.PermissionStatus.granted:
        return PermissionStatus.granted;
      case handler.PermissionStatus.limited:
        return PermissionStatus.limited;
      case handler.PermissionStatus.restricted:
        return PermissionStatus.restricted;
      case handler.PermissionStatus.permanentlyDenied:
        return PermissionStatus.permanentlyDenied;
      case handler.PermissionStatus.provisional:
        return PermissionStatus.provisional;
    }
  }
}
