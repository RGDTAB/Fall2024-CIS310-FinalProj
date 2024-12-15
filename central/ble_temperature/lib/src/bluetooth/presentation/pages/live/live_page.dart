import 'package:ble_temperature/core/services/router_service.dart';
import 'package:ble_temperature/core/styles/app_styles.dart';
import 'package:ble_temperature/generated/l10n.dart';
import 'package:ble_temperature/src/bluetooth/data/utils/datablock.dart';
import 'package:ble_temperature/src/bluetooth/presentation/cubit/live/live_cubit.dart';
import 'package:ble_temperature/src/bluetooth/presentation/pages/live/live_page_history.dart';
import 'package:ble_temperature/src/bluetooth/presentation/pages/live/live_page_params.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LivePage extends StatefulWidget {
  const LivePage({required this.params, super.key});
  final LivePageParams params;

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  LivePageHistory history = LivePageHistory();
  final _scrollController = ScrollController();
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
        LiveStateUpdate(data: final data) => _buildUpdate(context, data),
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

  Widget _buildUpdate(BuildContext context, Datablock value) {
    history.updateHistory(value);
    return Scaffold(
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
            child: ListView(
              children: [
                ExpansionTile(
                  title: Text(S.of(context).livePageCardTitle),
                  subtitle: Text(
                    '${value.temp.toStringAsFixed(2)} ${S.of(context).livePageUnit}',
                  ),
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Ideal temperature range for sleep is between '
                            '60 and 72 degrees Fahrenheit\n'
                            'Average: ${history.tempAvg.toStringAsFixed(2)}'
                            '${S.of(context).livePageUnit}\n'
                            'Min: ${history.tempMin.toStringAsFixed(2)}'
                            '${S.of(context).livePageUnit}'
                            ' at ${DateFormat.yMd().add_jm().format(history.tempMinTime)}\n'
                            'Max: ${history.tempMax.toStringAsFixed(2)}'
                            '${S.of(context).livePageUnit}'
                            ' at ${DateFormat.yMd().add_jm().format(history.tempMaxTime)}\n'
                            'The graph will take 60 seconds to populate with '
                            'new data.',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (history.longHistory.length >= 2) SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: 200 * history.longHistory.length.toDouble(),
                        height: 400,
                        child: LineChart(history.sampleDataTemp),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Humidity'),
                  subtitle: Text(
                    '${value.hum.toStringAsFixed(2)} %',
                  ),
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Text(
                            'Ideal humidity range for sleep is between '
                            '30 and 50%.\n'
                            'Average: ${history.humAvg.toStringAsFixed(2)}'
                            '%\n'
                            'Min: ${history.humMin.toStringAsFixed(2)}'
                            '% at ${DateFormat.yMd().add_jm().format(history.humMaxTime)}\n'
                            'Max: ${history.humMax.toStringAsFixed(2)}'
                            '% at ${DateFormat.yMd().add_jm().format(history.humMinTime)}\n'
                            'The graph will take 60 seconds to populate with '
                            'new data.',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (history.longHistory.length >= 2) SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: 200 * history.longHistory.length.toDouble(),
                        height: 500,
                        child: LineChart(history.sampleDataHum),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Light'),
                  subtitle: Text(
                    '${value.light} lx',
                  ),
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Text('Ambient light (measured in lux) should be kept '
                              'as low as possible for ideal sleep conditions.\n'
                              'Average: ${history.lightAvg.toStringAsFixed(2)}'
                              'Min: ${history.lightMin.toStringAsFixed(2)}'
                              '% at ${DateFormat.yMd().add_jm().format(history.lightMaxTime)}\n'
                              'Max: ${history.lightMax.toStringAsFixed(2)}'
                              '% at ${DateFormat.yMd().add_jm().format(history.lightMinTime)}\n'
                              'The graph will take 60 seconds to populate with '
                              'new data.',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (history.longHistory.length >= 2) SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: 200 * history.longHistory.length.toDouble(),
                        height: 400,
                        child: LineChart(history.sampleDataLight),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Noise'),
                  subtitle: Text(
                    '${value.noise} (raw PCM)',
                  ),
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child:
                        Text('Sound values are recorded in raw Pulse Code '
                          "Modulation taken directly from the Arduino's "
                          'microphone. From our own testing we concluded that '
                          'snoring typically results in values between 50 and '
                          '400 when the sensor is placed a few feet away from '
                          'the subject. Your mileage may vary.\n'
                          'Average: ${history.noiseAvg.toStringAsFixed(2)}\n'
                          'Max: ${history.noiseMax.toStringAsFixed(2)} '
                          'at ${DateFormat.yMd().add_jm().format(history.lightMinTime)}\n'
                          'The graph will take 60 seconds to populate with '
                          'new data.',
                        ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    if (history.longHistory.length >= 2) SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: 200 * history.longHistory.length.toDouble(),
                        height: 400,
                        child: LineChart(history.sampleDataNoise),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }

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
                  icon: Icon(MdiIcons.reload),
                  label: Text(S.of(context).livePageLabelRetry),
                ),
              ],
            ),
          ),
        ),
      );
}
