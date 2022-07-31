// ignore_for_file: must_be_immutable

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cup_cake/functions/filteration.dart';
import 'package:cup_cake/functions/scroll_behaviour.dart';
import 'package:cup_cake/functions/widgets.dart';
import 'package:cup_cake/screens/all_transactions.dart';
import 'package:cup_cake/graphfiles/graph.dart';
import 'package:cup_cake/screens/homepage.dart';
import 'package:cup_cake/screens/settings.dart';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../db/transaction_db.dart';

import '../functions/colors_and_style.dart';
import '../modals/category_modal.dart';
import 'add_new.dart';

int totalBalance = 0;
int totalIncome = 0;
int totalExpense = 0;

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final obj = Widgets();
  final colorsobj = Colours();

  @override
  void initState() {
    filterFunction();
    super.initState();
  }

  String userName = 'user';
  int currentindex = 0;
  final screens = [
    const Homespages(),
    const AllTransaction(),
    const Graphs(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    getTotalBalance();
    return Container(
      decoration: BoxDecoration(
        gradient: colorsobj.colorslight(),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(
            // top: 3,
            left: 15,
            right: 15,
            // bottom: 15,
          ),
          child: SafeArea(
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: LayoutBuilder(
                builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: screens[currentindex],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 147, 232, 225),
          elevation: 10,
          onPressed: () {
            Get.to(
              AddTransaction(),
              transition: Transition.zoom,
              duration: const Duration(
                milliseconds: 500,
              ),
            );
          },
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            gradient: colorsobj.colorsdark(),
            borderRadius: BorderRadius.circular(100),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 187, 251, 247),
                blurRadius: 10.0,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: AnimatedBottomNavigationBar(
            backgroundColor: Colors.transparent,
            activeColor: const Color.fromARGB(255, 219, 145, 201),
            inactiveColor: const Color.fromARGB(255, 27, 88, 83),
            icons: const [
              Icons.home_outlined,
              Icons.format_list_bulleted_rounded,
              Icons.pie_chart_outline,
              Icons.settings_outlined,
            ],
            activeIndex: currentindex,
            gapLocation: GapLocation.center,
            leftCornerRadius: 50,
            rightCornerRadius: 50,
            onTap: (index) {
              setState(
                () {
                  currentindex = index;
                },
              );
            },
          ),
        ),
      ),
    );
  }

  getTotalBalance() async {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;

    for (var element in transactionListNotifier.value) {
      if (element.type == CategoryType.income) {
        setState(() {
          totalBalance = totalBalance + element.amount;
          totalIncome = totalIncome + element.amount;
        });
      } else {
        setState(() {
          totalBalance = totalBalance - element.amount;
          totalExpense = totalExpense + element.amount;
        });
      }
    }
  }
}
