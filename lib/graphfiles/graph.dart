import 'package:cup_cake/db/transaction_db.dart';
import 'package:cup_cake/functions/filteration.dart';
import 'package:cup_cake/functions/widgets.dart';
import 'package:cup_cake/graphfiles/pie_data.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../functions/colors_and_style.dart';

class Graphs extends StatefulWidget {
  const Graphs({Key? key}) : super(key: key);

  @override
  State<Graphs> createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> with TickerProviderStateMixin {
  List<ChartData> data = chartLogic(expenseNotifier.value);
  List<ChartData> dataIncome = chartLogic(incomeNotifier.value);
  List<ChartData> overall = chartLogic(transactionListNotifier.value);
  List<ChartData> yesterday = chartLogic(yesterdayNotifier.value);
  List<ChartData> today = chartLogic(todayNotifier.value);
  List<ChartData> month = chartLogic(lastMonthNotifier.value);
  List<ChartData> week = chartLogic(lastWeekNotifier.value);
  List<ChartData> todayIncome = chartLogic(incomeTodayNotifier.value);
  List<ChartData> incomeYesterday = chartLogic(incomeYesterdayNotifier.value);
  List<ChartData> incomeweek = chartLogic(incomeLastWeekNotifier.value);
  List<ChartData> incomemonth = chartLogic(incomeLastMonthNotifier.value);
  List<ChartData> todayExpense = chartLogic(expenseTodayNotifier.value);
  List<ChartData> expenseYesterday = chartLogic(expenseYesterdayNotifier.value);
  List<ChartData> expenseweek = chartLogic(expenseLastWeekNotifier.value);
  List<ChartData> expensemonth = chartLogic(expenseLastMonthNotifier.value);


  
  

  String categoryId2 = 'Date-all';

  final obj = Widgets();
  final colorsobj = Colours();
  int touchIndex = 1;


  @override
  Widget build(BuildContext context) {
  
    
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TabController tabController = TabController(length: 2, vsync: this);
    return Column(
      children: [
        SizedBox(
          height: height * 0.0197,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: width * 0.055),
            Text(
              'Transaction  Statistics',
              style: colorsobj.styles(),
            ),
            obj.appLogo(),
          ],
        ),
        SizedBox(
          height: height * 0.039,
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 24,
          ),
          child: Material(
            shadowColor: const Color.fromARGB(255, 187, 251, 247),
            borderRadius: BorderRadius.circular(18),
            elevation: 10,
            child: Container(
              height: height * 0.0657,
              width: width * 0.83,
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
                    DropdownButton<String>(
                      underline: const Divider(
                        color: Colors.transparent,
                      ),
                      style: colorsobj.styles(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                      value: categoryId2,
                      items: <String>[
                        'Date-all',
                        'Today',
                        'Yesterday',
                        'This week',
                        'This month',
                      ]
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          categoryId2 = value.toString();
                        });
                      },
                    )
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
           /*  Tab(
              text: 'Overall',
            ), */
            Tab(
              text: 'Income',
            ),
            Tab(
              text: 'Expense',
            ),
          ],
        ),
        SizedBox(
          height: height * 0.0263,
        ),
        SizedBox(
          width: double.maxFinite,
          height: height * 0.526,
          child: TabBarView(
            controller: tabController,
            children: [
             /*  Padding(
                padding: const EdgeInsets.all(
                  16,
                ),
                child: overall.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Lottie.asset(
                              'assets/images/lottie/90992-graph4.json',
                            ),
                          ),
                          const Text(
                            'There is no enough data to display the graph.',
                          ),
                        ],
                      )
                    : SfCircularChart(
                        legend: Legend(isVisible: true),
                        series: <CircularSeries>[
                          PieSeries<ChartData, String>(
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                            dataSource: chartdivertFunctionAll(),
                            xValueMapper: (ChartData data, _) =>
                                data.categories,
                            yValueMapper: (ChartData data, _) => data.amount,
                            explode: true,
                          )
                        ],
                      ),
              ), */
              Padding(
                padding: const EdgeInsets.all(
                  16,
                ),
                child: chartdivertFunctionIncome().isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Lottie.asset(
                              'assets/images/lottie/90992-graph4.json',
                            ),
                          ),
                          const Text(
                            'There is no enough data to display the graph.',
                          ),
                        ],
                      )
                    : SfCircularChart(
                        legend: Legend(isVisible: true),
                        series: <CircularSeries>[
                          PieSeries<ChartData, String>(
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                            dataSource: chartdivertFunctionIncome(),
                            xValueMapper: (ChartData data, _) =>
                                data.categories,
                            yValueMapper: (ChartData data, _) => data.amount,
                            explode: true,
                          )
                        ],
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  16,
                ),
                child: chartdivertFunctionExpense().isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Lottie.asset(
                              'assets/images/lottie/90992-graph4.json',
                            ),
                          ),
                          const Text(
                            'There is no enough data to display the graph.',
                          ),
                        ],
                      )
                    : SfCircularChart(
                        legend: Legend(isVisible: true),
                        series: <CircularSeries>[
                          PieSeries<ChartData, String>(
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                            dataSource: chartdivertFunctionExpense(),
                            xValueMapper: (ChartData data, _) =>
                                data.categories,
                            yValueMapper: (ChartData data, _) => data.amount,
                            explode: true,
                          )
                        ],
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
/* 
  chartdivertFunctionAll() {
    if (categoryId2 == 'Date-all') {
      return overall;
    }
    if (categoryId2 == 'Today') {
      return today;
    }
    if (categoryId2 == 'Yesterday') {
      return yesterday;
    }
    if (categoryId2 == 'This week') {
      return week;
    }
    if (categoryId2 == 'This month') {
      return month;
    }
  } */

  chartdivertFunctionIncome() {
    if (categoryId2 == 'Date-all') {

      return dataIncome;
    }
    if (categoryId2 == 'Today') {
      return todayIncome;
    }
    if (categoryId2 == 'Yesterday') {
      return incomeYesterday;
    }
    if (categoryId2 == 'This week') {
      return incomeweek;
    }
    if (categoryId2 == 'This month') {
      return incomemonth;
    }
  }

  chartdivertFunctionExpense() {
    if (categoryId2 == 'Date-all') {
      return data;
    }
    if (categoryId2 == 'Today') {
      return todayExpense;
    }
    if (categoryId2 == 'Yesterday') {
      return expenseYesterday;
    }
    if (categoryId2 == 'This week') {
      return expenseweek;
    }
    if (categoryId2 == 'This month') {
      return expensemonth;
    }
  }
}
