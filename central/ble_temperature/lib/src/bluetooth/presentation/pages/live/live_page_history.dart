import 'package:ble_temperature/src/bluetooth/data/utils/datablock.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class LivePageHistory {
  List<Datablock> longHistory = <Datablock>[];
  List<Datablock> recentHistory = List<Datablock>.filled(6,
    const Datablock(temp: 0, hum: 0, light: 0, noise: 0, flag: false),
  );
  int currentSample = 0;

  int samples = 0;
  int startTime = DateTime.now().millisecondsSinceEpoch;
  int currentTime = DateTime.now().millisecondsSinceEpoch;

  double tempAvg = 0;
  double tempMin = 1000000;
  DateTime tempMinTime = DateTime.now();
  double tempMax = 0;
  DateTime tempMaxTime = DateTime.now();

  double humAvg = 0;
  double humMin = 1000000;
  DateTime humMinTime = DateTime.now();
  double humMax = 0;
  DateTime humMaxTime = DateTime.now();

  double noiseAvg = 0;
  int noiseMax = 0;
  DateTime noiseMaxTime = DateTime.now();

  double lightAvg = 0;
  int lightMin = 1000000;
  DateTime lightMinTime = DateTime.now();
  int lightMax = 0;
  DateTime lightMaxTime = DateTime.now();

  List<LineChartBarData> get lineBarsDataTemp => [
    LineChartBarData(
      color: const Color.fromARGB(255, 102, 87, 111),
      barWidth: 6,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) =>
          FlDotCirclePainter(
            radius: 8,
            color: const Color.fromARGB(255, 102, 87, 111),
          ),
      ),
      spots: List<FlSpot>.generate(
        longHistory.length,
        (int index) => FlSpot(index.toDouble(), longHistory[index].temp),
        growable: false,
      ),
      ),
  ];

  List<LineChartBarData> get lineBarsDataHum => [
    LineChartBarData(
      color: const Color.fromARGB(255, 102, 87, 111),
      barWidth: 6,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) =>
          FlDotCirclePainter(
            radius: 8,
            color: const Color.fromARGB(255, 102, 87, 111),
          ),
      ),
      spots: List<FlSpot>.generate(
        longHistory.length,
        (int index) => FlSpot(index.toDouble(), longHistory[index].hum),
        growable: false,
      ),
    ),
  ];

  List<LineChartBarData> get lineBarsDataNoise => [
    LineChartBarData(
      color: const Color.fromARGB(255, 102, 87, 111),
      barWidth: 6,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) =>
          FlDotCirclePainter(
            radius: 8,
            color: const Color.fromARGB(255, 102, 87, 111),
          ),
      ),
      spots: List<FlSpot>.generate(
        longHistory.length,
        (int index) => FlSpot(index.toDouble(), longHistory[index].noise.toDouble()),
        growable: false,
      ),
    ),
  ];

  List<LineChartBarData> get lineBarsDataLight => [
    LineChartBarData(
      color: const Color.fromARGB(255, 102, 87, 111),
      barWidth: 6,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) =>
          FlDotCirclePainter(
            radius: 8,
            color: const Color.fromARGB(255, 102, 87, 111),
          ),
      ),
      spots: List<FlSpot>.generate(
        longHistory.length,
        (int index) => FlSpot(index.toDouble(), longHistory[index].light.toDouble()),
        growable: false,
      ),
    ),
  ];


  Widget getHorizontalTitles(double value, TitleMeta meta) {
    TextStyle style;
      style = const TextStyle(
        color: Colors.white60,
        fontSize: 14,
      );
    final lerp = value / longHistory.length;
    final mili = (startTime * (1 - lerp)) + (currentTime * lerp);
    final time = DateTime.fromMillisecondsSinceEpoch(mili.round());
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text('${time.hour}:${time.minute.toString().padLeft(2, '0')}',
        style: style,
      ),
    );
  }

  Widget getVerticalTempTitles(double value, TitleMeta meta) {
    TextStyle style;
    style = const TextStyle(
      color: Colors.white60,
      fontSize: 14,
    );

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text('${meta.formattedValue} °F', style: style),
    );
  }
  Widget getVerticalHumTitles(double value, TitleMeta meta) {
    TextStyle style;
    style = const TextStyle(
      color: Colors.white60,
      fontSize: 14,
    );

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text('${meta.formattedValue}%', style: style),
    );
  }
  Widget getVerticalNoiseTitles(double value, TitleMeta meta) {
    TextStyle style;
    style = const TextStyle(
      color: Colors.white60,
      fontSize: 14,
    );

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(meta.formattedValue, style: style),
    );
  }
  Widget getVerticalLightTitles(double value, TitleMeta meta) {
    TextStyle style;
    style = const TextStyle(
      color: Colors.white60,
      fontSize: 14,
    );

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text('${meta.formattedValue}lx', style: style),
    );
  }

  LineChartData get sampleDataTemp => LineChartData(
    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        getTooltipColor: (touchedSpot) => Colors.black.withOpacity(0.2),
        getTooltipItems: (List<LineBarSpot> lineBarSpots) {
          return lineBarSpots.map((lineBarSpot) {
            return LineTooltipItem(
              lineBarSpot.y.toStringAsFixed(1),
              const TextStyle(),
            );
          }).toList();
        },
      ),
    ),
    gridData: const FlGridData(
      show: false,
      horizontalInterval: 1,
    ),
    titlesData: FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: getHorizontalTitles,
          reservedSize: 54,
          interval: 1,
        ),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(
          reservedSize: 36,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: getVerticalTempTitles,
          reservedSize: 54,
        ),
      ),
      rightTitles: const AxisTitles(),
    ),
    extraLinesData: ExtraLinesData(
      horizontalLines: [
        HorizontalLine(
          y: 60,
          color: Colors.blueAccent,
          dashArray: [5, 5],
        ),
        HorizontalLine(
          y: 72,
          color: Colors.blueAccent,
          dashArray: [5, 5],
        ),
      ],
    ),
    borderData: FlBorderData(show: true),
    clipData: const FlClipData(top: true, bottom: true, left: true, right: true),
    lineBarsData: lineBarsDataTemp,
    minY: tempMin < 60 ? tempMin - 3: 57,
    maxY: tempMax > 72 ? tempMax + 3: 75,
  );

  LineChartData get sampleDataHum => LineChartData(
    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        getTooltipColor: (touchedSpot) => Colors.black.withOpacity(0.2),
        getTooltipItems: (List<LineBarSpot> lineBarSpots) {
          return lineBarSpots.map((lineBarSpot) {
            return LineTooltipItem(
              lineBarSpot.y.toStringAsFixed(1),
              const TextStyle(),
            );
          }).toList();
        },
      ),
    ),
    gridData: const FlGridData(
      horizontalInterval: 10,
    ),
    titlesData: FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: getHorizontalTitles,
          reservedSize: 54,
          interval: 1,
        ),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(
          reservedSize: 36,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: getVerticalHumTitles,
          reservedSize: 66,
        ),
      ),
      rightTitles: const AxisTitles(),
    ),
    borderData: FlBorderData(show: true),
    clipData: const FlClipData(top: true, bottom: true, left: true, right: true),
    extraLinesData: ExtraLinesData(
      horizontalLines: [
        HorizontalLine(
          y: 30,
          color: Colors.blueAccent,
          dashArray: [5, 5],
        ),
        HorizontalLine(
          y: 50,
          color: Colors.blueAccent,
          dashArray: [5, 5],
        ),
      ],
    ),
    lineBarsData: lineBarsDataHum,
    minY: 0,
    maxY: 100,
  );

  LineChartData get sampleDataLight => LineChartData(
    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        getTooltipColor: (touchedSpot) => Colors.black.withOpacity(0.2),
        getTooltipItems: (List<LineBarSpot> lineBarSpots) {
          return lineBarSpots.map((lineBarSpot) {
            return LineTooltipItem(
              lineBarSpot.y.toStringAsFixed(0),
              const TextStyle(),
            );
          }).toList();
        },
      ),
    ),
    gridData: const FlGridData(
      show: false,
    ),
    titlesData: FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: getHorizontalTitles,
          reservedSize: 54,
          interval: 1,
        ),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
          reservedSize: 36,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: getVerticalLightTitles,
          reservedSize: 54,
        ),
      ),
      rightTitles: const AxisTitles(),
    ),
    borderData: FlBorderData(show: true),
    clipData: const FlClipData(top: true, bottom: true, left: true, right: true),
    lineBarsData: lineBarsDataLight,
    minY: (lightMin - 3 >= 0) ? lightMin.toDouble() : 0,
    maxY: lightMax.toDouble(),
  );

  LineChartData get sampleDataNoise => LineChartData(
    lineTouchData: LineTouchData(
      enabled: true,
      touchTooltipData: LineTouchTooltipData(
        getTooltipColor: (touchedSpot) => Colors.black.withOpacity(0.2),
        getTooltipItems: (List<LineBarSpot> lineBarSpots) {
          return lineBarSpots.map((lineBarSpot) {
            return LineTooltipItem(
              lineBarSpot.y.toStringAsFixed(0),
              const TextStyle(),
            );
          }).toList();
        },
      ),
    ),
    gridData: const FlGridData(
      show: true,
      horizontalInterval: 150,
    ),
    titlesData: FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: getHorizontalTitles,
          reservedSize: 54,
          interval: 1,
        ),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
          reservedSize: 36,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: getVerticalNoiseTitles,
          reservedSize: 54,
        ),
      ),
      rightTitles: const AxisTitles(),
    ),
    borderData: FlBorderData(show: true),
    clipData: const FlClipData(top: true, bottom: true, left: true, right: true),
    lineBarsData: lineBarsDataNoise,
    extraLinesData: ExtraLinesData(
      horizontalLines: [
        HorizontalLine(
          y: 50,
          color: Colors.redAccent,
          dashArray: [5, 5],
        ),
        HorizontalLine(
          y: 400,
          color: Colors.redAccent,
          dashArray: [5, 5],
        ),
      ],
    ),
    minY: 0,
    maxY: 900,
  );

  Datablock averageRecentHistory() {
    var temp = 0.0;
    var hum = 0.0;
    var noise = 0.0;
    var light = 0.0;

    for (final sample in recentHistory) {
      temp += sample.temp;
      hum += sample.hum;
      if (sample.noise > noise) {
        noise = sample.noise.toDouble();
      }
      light += sample.light;
    }
    temp /= recentHistory.length;
    hum /= recentHistory.length;
    light /= recentHistory.length;

    return Datablock(
      temp: temp, hum: hum, light: light.round(), noise: noise.round(),
      flag: false,
    );
  }

  void updateRecentHistory(Datablock update) {
    recentHistory[currentSample++] = update;

    if (currentSample >= recentHistory.length) {
      longHistory.add(averageRecentHistory());
      currentSample = currentSample % recentHistory.length;
      currentTime = DateTime.now().millisecondsSinceEpoch;
    }
  }

  void updateHistory(Datablock update) {
    updateRecentHistory(update);
    samples++;

    tempAvg *= samples - 1;
    tempAvg += update.temp;
    tempAvg /= samples;
    if (update.temp > tempMax) {
      tempMax = update.temp;
      tempMaxTime = DateTime.now();
    } else if (update.temp < tempMin) {
      tempMin = update.temp;
      tempMinTime = DateTime.now();
    }

    humAvg *= samples - 1;
    humAvg += update.hum;
    humAvg /= samples;
    if (update.hum > humMax) {
      humMax = update.hum;
      humMaxTime = DateTime.now();
    } else if (update.hum < humMin) {
      humMin = update.hum;
      humMinTime = DateTime.now();
    }

    noiseAvg *= samples - 1;
    noiseAvg += update.noise;
    noiseAvg /= samples;
    if (update.noise > noiseMax) {
      noiseMax = update.noise;
      noiseMaxTime = DateTime.now();
    }

    lightAvg *= samples - 1;
    lightAvg += update.light;
    lightAvg /= samples;
    if (update.light > lightMax) {
      lightMax = update.light;
      lightMaxTime = DateTime.now();
    } else if (update.light < lightMin) {
      lightMin = update.light;
      lightMinTime = DateTime.now();
    }
  }
}
