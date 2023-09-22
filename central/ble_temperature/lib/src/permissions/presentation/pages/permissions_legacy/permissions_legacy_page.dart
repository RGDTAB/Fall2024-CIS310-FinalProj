import 'package:ble_temperature/core/services/router_service.dart';
import 'package:ble_temperature/core/styles/app_styles.dart';
import 'package:ble_temperature/generated/l10n.dart';
import 'package:ble_temperature/src/permissions/domain/enums/permission_status.dart';
import 'package:ble_temperature/src/permissions/presentation/cubit/permissions_legacy/permissions_legacy_cubit.dart';
import 'package:ble_temperature/src/permissions/presentation/widgets/permission_status_widget.dart';
import 'package:ble_temperature/src/permissions/presentation/widgets/service_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PermissionsLegacyPage extends StatefulWidget {
  const PermissionsLegacyPage({super.key});

  @override
  State<PermissionsLegacyPage> createState() => _PermissionsLegacyPageState();
}

class _PermissionsLegacyPageState extends State<PermissionsLegacyPage>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        context.read<PermissionsLegacyCubit>().update();
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<PermissionsLegacyCubit>().update();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PermissionsLegacyCubit, PermissionsLegacyState>(
      listener: (context, state) {
        switch (state) {
          case final PermissionsLegacyStateUpdate update:
            if (update.serviceLocationEnabled &&
                update.statusLocationWhenInUse == PermissionStatus.granted) {
              Navigator.of(context).pushReplacementNamed(Routes.bleInitPage);
            }
          default:
            break;
        }
      },
      builder: (context, state) => switch (state) {
        PermissionsLegacyStateLoading() => _buildLoadingState(context),
        PermissionsLegacyStateUpdate(
          serviceLocationEnabled: final serviceLocationEnabled,
          statusLocationWhenInUse: final statusLocationWhenInUse
        ) =>
          _buildUpdateState(
            context,
            serviceLocationEnabled,
            statusLocationWhenInUse,
          ),
        PermissionsLegacyStateError() => _buildErrorState(context),
      },
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).screenPermissionsTitle),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildUpdateState(
    BuildContext context,
    bool serviceLocationEnabled,
    PermissionStatus statusLocationWhenInUse,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).screenPermissionsTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppStyles.edgeInsetsSmall,
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
                },
              ),
              ServiceStatusWidget(
                title: S.of(context).screenPermissionLegacyLocationServiceTitle,
                body: S.of(context).screenPermissionLegacyLocationServiceBody,
                status: serviceLocationEnabled,
                action: S.of(context).screenPermissionLegacyLocationServiceOpen,
                onPressed: () {
                  context
                      .read<PermissionsLegacyCubit>()
                      .requestLocationService();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).screenPermissionsTitle),
      ),
      body: Center(
        child: Padding(
          padding: AppStyles.edgeInsetsLarge,
          child: Text(S.of(context).livePageError),
        ),
      ),
    );
  }
}
