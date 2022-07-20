import 'package:cup_cake/data/pie_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<PieChartSectionData> getsections() => PieData.data
    .asMap()
    .map<int, PieChartSectionData>(
      (index, data) {
        final value = PieChartSectionData(
          color: data.color,
          value: data.percent,
          title: '${data.percent}%',
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
        return MapEntry(index, value);
      },
    )
    .values
    .toList();
