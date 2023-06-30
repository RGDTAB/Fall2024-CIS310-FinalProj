import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../config/app_routes.dart';
import '../../../globals.dart';
import '../../bloc/permissions_legacy/permissions_legacy_cubit.dart';
import '../widgets/permission_status_widget.dart';
import 'service_status_widget.dart';

class PermissionsLegacyPage extends StatefulWidget {
  const PermissionsLegacyPage({Key? key}) : super(key: key);

  @override
  State<PermissionsLegacyPage> createState() => _PermissionsLegacyPageState();
}

class _PermissionsLegacyPageState extends State<PermissionsLegacyPage>
    with WidgetsBindingObserver {
  final _permissionsLegacyCubit =
      PermissionsLegacyCubit(permissionsFacade: getIt());

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _permissionsLegacyCubit.update();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _permissionsLegacyCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _permissionsLegacyCubit,
        child: BlocConsumer<PermissionsLegacyCubit, PermissionsLegacyState>(
            listener: (context, state) {
          state.whenOrNull(
            update: (serviceLocationEnabled, statusLocationWhenInUse) {
              if (serviceLocationEnabled &&
                  statusLocationWhenInUse == PermissionStatus.granted) {
                Navigator.of(context).pushReplacementNamed(Routes.bleInitPage);
              }
            },
          );
        }, builder: (context, state) {
          return state.when(loading: () {
            return Scaffold(
                appBar: AppBar(
                  title: Text(S.of(context).screenPermissionsTitle),
                ),
                body: _buildLoadingState());
          }, update: (serviceLocationEnabled, statusLocationWhenInUse) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(S.of(context).screenPermissionsTitle),
                ),
                body: _buildUpdateState(
                    context, serviceLocationEnabled, statusLocationWhenInUse));
          });
        }));
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildUpdateState(
    BuildContext context,
    bool serviceLocationEnabled,
    PermissionStatus statusLocationWhenInUse,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PermissionStatusWidget(
              title: S.of(context).screenPermissionLegacyLocationTitle,
              body: S.of(context).screenPermissionLegacyLocationBody,
              status: statusLocationWhenInUse,
              action: S.of(context).screenPermissionsRequestPermission,
              onPressed: () {
                context.read<PermissionsLegacyCubit>().requestLocation();
              }),
          ServiceStatusWidget(
              title: S.of(context).screenPermissionLegacyLocationServiceTitle,
              body: S.of(context).screenPermissionLegacyLocationServiceBody,
              status: serviceLocationEnabled,
              action: S.of(context).screenPermissionLegacyLocationServiceOpen,
              onPressed: () {
                context.read<PermissionsLegacyCubit>().requestLocationService();
              }),
        ],
      ),
    );
  }
}
