import 'package:ble_temperature/core/styles/app_styles.dart';
import 'package:ble_temperature/generated/l10n.dart';
import 'package:ble_temperature/src/permissions/domain/enums/permission_status.dart';
import 'package:flutter/material.dart';

class PermissionStatusWidget extends StatelessWidget {
  const PermissionStatusWidget({
    required this.title,
    required this.body,
    required this.status,
    required this.action,
    this.onPressed,
    super.key,
  });
  final String title;
  final String body;
  final PermissionStatus status;
  final String action;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return _buildPermissionEntry(
      context,
      title,
      body,
      action,
      status,
      onPressed,
    );
  }

  Widget _buildPermissionEntry(
    BuildContext context,
    String title,
    String body,
    String action,
    PermissionStatus status,
    void Function()? onPressed,
  ) {
    return Card(
      margin: AppStyles.edgeInsetsSmall,
      child: Padding(
        padding: AppStyles.edgeInsetsMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: AppStyles.edgeInsetsZero,
              title: Text(title),
              trailing: status == PermissionStatus.granted
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).primaryColor,
                    )
                  : const Icon(
                      Icons.close,
                    ),
            ),
            const Divider(),
            Text(
              body,
            ),
            const Padding(padding: AppStyles.edgeInsetsMedium),
            Text(
              '${S.of(context).screenPermissionStatus} '
              '${_statusToString(context, status)}',
            ),
            const Padding(padding: AppStyles.edgeInsetsMedium),
            OutlinedButton(
              onPressed: status == PermissionStatus.granted ? null : onPressed,
              child: Text(
                action,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _statusToString(BuildContext context, PermissionStatus status) {
    switch (status) {
      case PermissionStatus.denied:
        return S.of(context).screenPermissionsDenied;
      case PermissionStatus.granted:
        return S.of(context).screenPermissionsGranted;
      case PermissionStatus.limited:
        return S.of(context).screenPermissionsLimited;
      case PermissionStatus.permanentlyDenied:
        return S.of(context).screenPermissionsPermanentlyDenied;
      case PermissionStatus.restricted:
        return S.of(context).screenPermissionsRestricted;
      case PermissionStatus.provisional:
        return S.of(context).screenPermissionsProvisional;
    }
  }
}
