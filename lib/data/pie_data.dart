import 'package:flutter/material.dart';

class PieData {
  static List<Data> data = [
    Data(
      name: 'blue',
      percent: 40,
      color:Colors.blue
    ),
    Data(
      name: 'Yellow',
      percent: 40,
      color: Colors.yellow,
    ),
    Data(
      name: 'green',
      percent: 40,
      color: Colors.green,
    ),
    Data(
      name: 'red',
      percent: 40,
      color:Colors.red,
    ),
  ];
}

class Data {
  final String name ;
  final double percent;
  final Color color;
  Data({required this.name,required this.percent,required this.color});
}
