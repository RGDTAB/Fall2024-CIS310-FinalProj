import 'package:ble_temperature/core/services/router_service.dart';
import 'package:ble_temperature/core/styles/app_styles.dart';
import 'package:ble_temperature/generated/l10n.dart';
import 'package:ble_temperature/src/bluetooth/presentation/cubit/live/live_cubit.dart';
import 'package:ble_temperature/src/bluetooth/presentation/pages/live/live_page_params.dart';
import 'package:ble_temperature/src/bluetooth/presentation/widgets/thermostat/thermostat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LivePage extends StatefulWidget {
  const LivePage({required this.params, super.key});
  final LivePageParams params;

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  @override
  void initState() {
    super.initState();
    context.read<LiveCubit>().init(widget.params.device);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveCubit, LiveState>(
      builder: (context, state) => switch (state) {
        LiveStateLoading() => _buildLoading(context),
        LiveStateUpdate(value: final value) => _buildUpdate(context, value),
        LiveStateError() => _buildError(context),
      },
    );
  }

  Widget _buildLoading(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.params.device.name),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.aboutPage);
              },
              icon: const Icon(Icons.info),
            ),
          ],
        ),
        body: const Center(child: CircularProgressIndicator()),
      );

  Widget _buildUpdate(BuildContext context, double value) => Scaffold(
        appBar: AppBar(
          title: Text(widget.params.device.name),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.aboutPage);
              },
              icon: const Icon(Icons.info),
            ),
          ],
        ),
        body: Padding(
          padding: AppStyles.edgeInsetsMedium,
          child: Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(S.of(context).livePageCardTitle),
                  subtitle: Text(
                    '${value.toStringAsFixed(2)} ${S.of(context).livePageUnit}',
                  ),
                  onTap: () {},
                ),
                const Divider(
                  height: 0,
                  indent: AppStyles.sizeSmall,
                  endIndent: AppStyles.sizeSmall,
                ),
                Expanded(
                  child: Padding(
                    padding: AppStyles.edgeInsetsMedium,
                    child: Thermostat(
                      value: value,
                      scaleLow: -10,
                      scaleHight: 50,
                      scaleStep: 10,
                      glassColor: Theme.of(context).colorScheme.outline,
                      fillColor: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildError(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.params.device.name),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.aboutPage);
              },
              icon: const Icon(Icons.info),
            ),
          ],
        ),
        body: Padding(
          padding: AppStyles.edgeInsetsLarge,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.of(context).livePageError, textAlign: TextAlign.center),
                const SizedBox(
                  height: AppStyles.sizeLarge,
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    context.read<LiveCubit>().retry(widget.params.device);
                  },
                  icon: const Icon(MdiIcons.reload),
                  label: Text(S.of(context).livePageLabelRetry),
                ),
              ],
            ),
          ),
        ),
      );
}
