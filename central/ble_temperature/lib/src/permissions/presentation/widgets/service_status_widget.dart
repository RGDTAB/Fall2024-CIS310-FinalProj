import 'package:ble_temperature/core/styles/app_styles.dart';
import 'package:ble_temperature/generated/l10n.dart';
import 'package:flutter/material.dart';

class ServiceStatusWidget extends StatelessWidget {
  const ServiceStatusWidget({
    required this.title,
    required this.body,
    required this.status,
    required this.action,
    required this.onPressed,
    super.key,
  });
  final String title;
  final String body;
  final bool status;
  final String action;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return _build(context, title, body, action, status, onPressed);
  }

  Widget _build(
    BuildContext context,
    String title,
    String body,
    String action,
    bool status,
    void Function()? onPressed,
  ) {
    final activeString =
        S.of(context).screenPermissionLegacyLocationServiceActiv;
    final inactiveString =
        S.of(context).screenPermissionLegacyLocationServiceInactiv;
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
              trailing: status
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
            const Padding(
              padding: AppStyles.edgeInsetsMedium,
            ),
            Text(
              '${S.of(context).screenPermissionStatus} '
              '${status ? activeString : inactiveString}',
            ),
            const Padding(
              padding: AppStyles.edgeInsetsMedium,
            ),
            OutlinedButton(
              onPressed: status ? null : onPressed,
              child: Text(
                action,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
