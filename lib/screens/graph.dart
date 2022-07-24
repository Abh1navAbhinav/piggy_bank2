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
    TabController tabController = TabController(length: 2, vsync: this);
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 20,),
             Text('Transaction  Statistics',style: colorsobj.styles(),),
            obj.appLogo(),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 24,
          ),
          child: Material(
            shadowColor: Colors.grey[100],
            borderRadius: BorderRadius.circular(18),
            elevation: 20,
            child: Container(
              height: 50,
              width: 300,
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
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.maxFinite,
          height: 400,
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
                    centerSpaceRadius: 90,
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
