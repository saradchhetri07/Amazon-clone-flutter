import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../models/sales.dart';

class CategoryProductCharts extends StatelessWidget {
  List<Sales>? earnings = [];
  CategoryProductCharts(this.earnings, {super.key});

  Map<String, double> dataMap = {};

  //   = {
  //   "Flutter": 5,
  //   "React": 3,
  //   "Xamarin": 2,
  //   "Ionic": 2,
  // };

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < earnings!.length; i++) {
      dataMap[earnings![i].label] = earnings![i].earnings.toDouble();
    }
    return PieChart(
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 1000),
      chartLegendSpacing: 35,
      chartRadius: MediaQuery.of(context).size.width / 2,
      // colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 32,
      centerText: "Category",
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        // legendShape: _BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      chartValuesOptions: const ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
      // gradientList: ---To add gradient colors---
      // emptyColorGradient: ---Empty Color gradient---
    );
  }
}
