import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:flutter/material.dart';

class ChartData {
//list of devices
  List<String> devices = ['Klima', 'Işıklar', 'gaz'];

//list of colors representing devices
  List<Color> colors = [
    const Color.fromRGBO(255, 197, 66, 1),
    const Color.fromRGBO(61, 213, 152, 1),
    const Color.fromRGBO(255, 87, 95, 1),
  ];

//function to get the data for doughnut chart
  List<CircularStackEntry> getChartData(String period) {
    final List<CircularStackEntry> chartData = [
      CircularStackEntry(getEntry(period))
    ];
    return chartData;
  }

//dummy data for monthly savings in form of percentage i.e. 50 means 50%
  final List<CircularSegmentEntry> _monthlySavings = <CircularSegmentEntry>[
    const CircularSegmentEntry(50, Color.fromRGBO(255, 197, 66, 1),
        rankKey: 'Klima'),
    const CircularSegmentEntry(10, Color.fromRGBO(255, 87, 95, 1),
        rankKey: 'Işıklar'),
    const CircularSegmentEntry(20, Color.fromRGBO(61, 213, 152, 1),
        rankKey: 'gaz'),
    const CircularSegmentEntry(100, Color.fromRGBO(42, 60, 68, 1),
        rankKey: 'bakiye'),
  ];

//dummy data for weekly savings
  final List<CircularSegmentEntry> _weeklySavings = <CircularSegmentEntry>[
    const CircularSegmentEntry(50, Color.fromRGBO(255, 197, 66, 1),
        rankKey: 'Klima'),
    const CircularSegmentEntry(10, Color.fromRGBO(255, 87, 95, 1),
        rankKey: 'Işıklar'),
    const CircularSegmentEntry(20, Color.fromRGBO(61, 213, 152, 1),
        rankKey: 'gaz'),
    const CircularSegmentEntry(100, Color.fromRGBO(42, 60, 68, 1),
        rankKey: 'bakiye')
  ];

  List<CircularSegmentEntry> getEntry(String period) {
    if (period == 'Aylık tassaruf') {
      return _monthlySavings;
    } else {
      return _weeklySavings;
    }
  }
}
