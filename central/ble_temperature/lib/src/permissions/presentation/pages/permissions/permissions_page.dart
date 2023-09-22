import 'package:ble_temperature/core/services/router_service.dart';
import 'package:ble_temperature/core/styles/app_styles.dart';
import 'package:ble_temperature/generated/l10n.dart';
import 'package:ble_temperature/src/permissions/domain/enums/permission_status.dart';
import 'package:ble_temperature/src/permissions/presentation/cubit/permissions/permissions_cubit.dart';
import 'package:ble_temperature/src/permissions/presentation/widgets/permission_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PermissionsPage extends StatefulWidget {
  const PermissionsPage({super.key});

  @override
  State<PermissionsPage> createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        context.read<PermissionsCubit>().update();
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
    context.read<PermissionsCubit>().update();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PermissionsCubit, PermissionsState>(
      listener: (context, state) {
        switch (state) {
          case final PermissionsStateUpdate update:
            if (update.statusScan == PermissionStatus.granted &&
                update.statusConnect == PermissionStatus.granted) {
              Navigator.of(context).pushReplacementNamed(Routes.bleInitPage);
            }
          default:
            break;
        }
      },
      builder: (context, state) => switch (state) {
        PermissionsStateLoading() => _buildLoadingState(context),
        PermissionsStateUpdate(
          statusScan: final statusScan,
          statusConnect: final statusConnect
        ) =>
          _buildUpdateState(context, statusScan, statusConnect),
        PermissionsStateError() => _buildErrorState(context),
      },
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).screenPermissionsTitle),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildUpdateState(
    BuildContext context,
    PermissionStatus statusScan,
    PermissionStatus statusConnect,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).screenPermissionsTitle),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppStyles.edgeInsetsSmall,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PermissionStatusWidget(
                title: S.of(context).screenPermissionsScanTitle,
                body: S.of(context).screenPermissionsScanBody,
                status: statusScan,
                action: S.of(context).screenPermissionsRequestPermission,
                onPressed: () {
                  context.read<PermissionsCubit>().requestScan();
                },
              ),
              PermissionStatusWidget(
                title: S.of(context).screenPermissionsConnectTitle,
                body: S.of(context).screenPermissionsConnectBody,
                status: statusConnect,
                action: S.of(context).screenPermissionsRequestPermission,
                onPressed: () {
                  context.read<PermissionsCubit>().requestConnect();
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
