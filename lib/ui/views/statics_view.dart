import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:coopmt_app/ui/labels/custom_labels.dart';
import 'package:coopmt_app/ui/shared/global/number_format.dart';
import 'package:coopmt_app/ui/shared/widgets/flchart_title_widgets.dart';

import 'package:coopmt_app/ui/views/notifications_view.dart';

class StaticsView extends StatefulWidget {
  static String id = 'statics_view';
  const StaticsView({Key? key}) : super(key: key);

  @override
  State<StaticsView> createState() => _StaticsView();
}

class _StaticsView extends State<StaticsView> {
  double? totalAmount = 1500.00;
  List<Color> gradientColors = [
    const Color(0xff54c500),
    const Color(0xff308a40),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String? title = ModalRoute.of(context)!.settings.arguments as String;

    if (title == null) {
      title = 'Estadísticas';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          textDirection: TextDirection.ltr,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        foregroundColor: const Color.fromRGBO(48, 138, 64, 1),
        backgroundColor: Colors.white,
        actions: <Widget>[
          ///Notifications
          IconButton(
              icon: const Icon(FontAwesomeIcons.solidBell),
              tooltip: 'Ver notificaciones',
              onPressed: () {
                Navigator.pushNamed(context, NotificationsView.id,
                    arguments: 'Notificaciones');
              }),

          ///Statics
          IconButton(
            icon: const Icon(FontAwesomeIcons.chartSimple),
            tooltip: 'Estadisticas',
            onPressed: () {
              Navigator.pushNamed(context, StaticsView.id,
                  arguments: 'Estadisticas');
            },
          ),

          ///Menu
          IconButton(
              icon: const Icon(FontAwesomeIcons.bars),
              tooltip: 'Abrir menu',
              onPressed: () => print('Abriste el menu'))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.072,
              ),

              ///Grafica
              SizedBox(
                height: size.height * 0.25,
                width: size.width * 0.85,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      horizontalInterval: 1,
                      verticalInterval: 1,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: const Color(0xff37434d),
                          strokeWidth: 1,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: const Color(0xff37434d),
                          strokeWidth: 1,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: bottomTitleWidgets,
                      )),
                      leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: leftTitleWidgets,
                      )),
                    ),
                    borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                            color: const Color(0xff37434d), width: 1)),
                    minX: 0,
                    maxX: 11,
                    minY: 0,
                    maxY: 6,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 3.3),
                          FlSpot(2.6, 2),
                          FlSpot(4.9, 5),
                          FlSpot(6.8, 3.1),
                          FlSpot(8, 4),
                          FlSpot(9.5, 3),
                          FlSpot(11, 4),
                        ],
                        isCurved: true,
                        gradient: LinearGradient(
                          colors: gradientColors,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        barWidth: 5,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: false,
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: gradientColors
                                .map((color) => color.withOpacity(0.3))
                                .toList(),
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // swapAnimationDuration:
                  //     const Duration(milliseconds: 150), // Optional
                  // swapAnimationCurve: Curves.linear, // Optional
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              ///List of options
            ],
          ),
        ),
      ),
    );
  }
}
