import 'package:cup_cake/functions/widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../data/piechart_functions.dart';
import '../functions/colors_and_style.dart';
import '../functions/state_widgets.dart';

class Graphs extends StatefulWidget {
  const Graphs({Key? key}) : super(key: key);

  @override
  State<Graphs> createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> with TickerProviderStateMixin {
  final obj = Widgets();
  final colorsobj = Colours();
  int touchIndex = 1;
  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TabController tabController = TabController(length: 2, vsync: this);
    return Column(
      children: [
         SizedBox(
          height: height*0.0197,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             SizedBox(
              width: width*0.055
            ),
            Text(
              'Transaction  Statistics',
              style: colorsobj.styles(),
            ),
            obj.appLogo(),
          ],
        ),
         SizedBox(
          height: height*0.039,
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 24,
          ),
          child: Material(
           shadowColor:  const Color.fromARGB(255, 187, 251, 247),
            borderRadius: BorderRadius.circular(18),
            elevation: 10,
            child: Container(
              height: height*0.0657,
              width: width*0.83,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: colorsobj.colorsdark(),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropDownButtons(
                      text: 'Date',
                      items: const <String>[
                        'Today',
                        'Yesterday',
                        'Month',
                        'Year',
                        'Custom',
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        TabBar(
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide.none,
          ),
          controller: tabController,
          labelStyle: colorsobj.styles(),
          labelColor: const Color.fromARGB(255, 27, 88, 83),
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(
              text: 'Income',
            ),
            Tab(
              text: 'Expense',
            ),
          ],
        ),
         SizedBox(
          height: height*0.0263,
        ),
        SizedBox(
          width: double.maxFinite,
          height: height*0.526,
          child: TabBarView(
            controller: tabController,
            children: [
              Padding(
                padding: const EdgeInsets.all(
                  16,
                ),
                child: PieChart(
                  PieChartData(
                    borderData: FlBorderData(
                      show: false,
                    ),
                    centerSpaceRadius: 50,
                    sections: getsections(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  16,
                ),
                child: PieChart(
                  PieChartData(
                    borderData: FlBorderData(
                      show: false,
                    ),
                    centerSpaceRadius: 50,
                    sections: getsections(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
