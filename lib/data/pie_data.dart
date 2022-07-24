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
      color: const Color.fromARGB(255, 203, 161, 193),
    ),
    Data(
      name: 'green',
      percent: 40,
      color: const Color.fromARGB(255, 82, 168, 85),
    ),
    Data(
      name: 'red',
      percent: 40,
      color:const Color.fromARGB(255, 171, 82, 76),
    ),
  ];
}

class Data {
  final String name ;
  final double percent;
  final Color color;
  Data({required this.name,required this.percent,required this.color});
}
