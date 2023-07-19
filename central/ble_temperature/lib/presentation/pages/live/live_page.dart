import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../config/app_routes.dart';
import '../../../config/app_styles.dart';
import '../../../generated/l10n.dart';
import '../../../globals.dart';
import '../../bloc/live/live_cubit.dart';
import '../widgets/thermostat/thermostat.dart';
import 'live_page_params.dart';

class LivePage extends StatelessWidget {
  final LivePageParams params;

  const LivePage({required this.params, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LiveCubit(
        device: params.device,
        ucConnect: getIt(),
        ucGetData: getIt(),
      )..init(),
      child: BlocBuilder<LiveCubit, LiveState>(
        builder: (context, state) => switch (state) {
          Loading() => _buildLoading(context),
          Update(value: final value) => _buildUpdate(context, value),
          Error() => _buildError(context),
        },
      ),
    );
  }

  Widget _buildLoading(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(params.device.name),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.aboutPage);
              },
              icon: const Icon(Icons.info))
        ],
      ),
      body: const Center(child: CircularProgressIndicator()));

  Widget _buildUpdate(BuildContext context, double value) => Scaffold(
        appBar: AppBar(
          title: Text(params.device.name),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.aboutPage);
                },
                icon: const Icon(Icons.info))
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
                      '${value.toStringAsFixed(2)} ${S.of(context).livePageUnit}'),
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
          title: Text(params.device.name),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.aboutPage);
                },
                icon: const Icon(Icons.info))
          ],
        ),
        body: Padding(
          padding: AppStyles.edgeInsetsLarge,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.of(context).livePageError, textAlign: TextAlign.center),
                const SizedBox(
                  height: AppStyles.sizeLarge,
                ),
                OutlinedButton.icon(
                    onPressed: () {
                      context.read<LiveCubit>().retry();
                    },
                    icon: const Icon(MdiIcons.reload),
                    label: Text(S.of(context).livePageLabelRetry))
              ],
            ),
          ),
        ),
      );
}
