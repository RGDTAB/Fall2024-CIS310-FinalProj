import 'package:ble_temperature/core/services/router_service.dart';
import 'package:ble_temperature/generated/l10n.dart';
import 'package:ble_temperature/src/bluetooth/presentation/cubit/scan/scan_cubit.dart';
import 'package:ble_temperature/src/bluetooth/presentation/pages/live/live_page_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanCubit, ScanState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).scanPageTitle),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.aboutPage);
                },
                icon: const Icon(Icons.info),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () {
              context.read<ScanCubit>().refresh();
              return Future.value();
            },
            child: ListView.separated(
              itemBuilder: (context, index) {
                final scan = state.scans.items.values.toList()[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${scan.rssi}'),
                  ),
                  title: Text(scan.name),
                  subtitle: Text(scan.id),
                  onTap: () {
                    context.read<ScanCubit>().stopScan();
                    Navigator.of(context)
                        .pushNamed(
                      Routes.livePage,
                      arguments: LivePageParams(device: scan),
                    )
                        .then((value) {
                      context.read<ScanCubit>().startScan();
                    });
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: state.scans.items.length,
            ),
          ),
        );
      },
    );
  }
}
