import 'package:ble_temperature/core/app_styles.dart';
import 'package:ble_temperature/generated/l10n.dart';
import 'package:flutter/material.dart';

class ServiceStatusWidget extends StatelessWidget {
  final String title;
  final String body;
  final bool status;
  final String action;
  final void Function()? onPressed;

  const ServiceStatusWidget(
      {required this.title,
      required this.body,
      required this.status,
      required this.action,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _build(context, title, body, action, status, onPressed);
  }

  Widget _build(BuildContext context, String title, String body, String action,
      bool status, void Function()? onPressed) {
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
              '${S.of(context).screenPermissionStatus} ${status ? S.of(context).screenPermissionLegacyLocationServiceActiv : S.of(context).screenPermissionLegacyLocationServiceActiv}',
            ),
            const Padding(
              padding: AppStyles.edgeInsetsMedium,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.tonal(
                  onPressed: onPressed,
                  child: Text(
                    action,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
