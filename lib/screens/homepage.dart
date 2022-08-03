// ignore_for_file: must_be_immutable

import 'package:cup_cake/db/username_db.dart';
import 'package:cup_cake/functions/function.dart';
import 'package:cup_cake/functions/scroll_behaviour.dart';
import 'package:cup_cake/functions/widgets.dart';
import 'package:cup_cake/modals/category_modal.dart';
import 'package:cup_cake/modals/transaction_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../db/transaction_db.dart';
import '../functions/colors_and_style.dart';
import 'add_new.dart';
import 'bottom_navigation.dart';

var formatter = NumberFormat('#,##,000');

class Homespages extends StatefulWidget {
  const Homespages({Key? key, a}) : super(key: key);

  @override
  State<Homespages> createState() => _HomespagesState();
}

class _HomespagesState extends State<Homespages> {
  final obj = Widgets();
  final colorsobj = Colours();
  final funtionsobj = Functions();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 3,
              top: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      funtionsobj.greeting(),
                      style: colorsobj.styles(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        funtionsobj.editUserName(context, 'change user Name');
                      },
                      child: Text(
                        userListNotifier.value.username,
                        style: colorsobj.styles(
                          fontSize: 22,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: width * 0.208,
                ),
                obj.appLogo(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.0294,
                bottom: MediaQuery.of(context).size.height * 0.026),
            child: Material(
              elevation: 5,
              color: Colors.transparent,
              shadowColor: const Color.fromARGB(255, 187, 251, 247),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: width * 0.888,
                decoration: BoxDecoration(
                  gradient: colorsobj.colorsdark(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.0407,
                    ),
                    Text(
                      totalBalance < 0
                          ? 'Total Debt'
                          : 'Total Balance',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 35,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 70,
                        vertical: 15,
                      ),
                      child: Row(
                        children: [
                          totalBalance >= 0
                              ? SizedBox(
                                  height: height * 0.0657,
                                  width: width * 0.138,
                                  child: const Image(
                                    image: AssetImage(
                                      'assets/images/piggy balance.png',
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: height * 0.0526,
                                  width: width * 0.11,
                                  child: const Image(
                                    image: AssetImage(
                                      'assets/images/icons/piggy-bank (2).png',
                                    ),
                                  ),
                                ),
                          SizedBox(
                            width: width * 0.0416,
                          ),
                          SizedBox(
                            width: width * 0.277,
                            height: height * 0.0394,
                            child: FittedBox(
                              child: Text(
                                totalBalance == 0
                                    ? '₹0.00'
                                    : '₹ ${formatter.format(totalBalance.abs())}',
                                style: colorsobj.styles(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500,
                                  color: totalBalance < 0
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              obj.incomeAndExpense(
                  context: context,
                  flag: true,
                  totalExpense: totalExpense,
                  totalIncome: totalIncome),
              obj.incomeAndExpense(
                context: context,
                flag: false,
                totalExpense: totalExpense,
                totalIncome: totalIncome,
              ),
            ],
          ),
          SizedBox(
            height: height * 0.045,
          ),
          Row(
            children: [
              Text(
                'Recent Transactions',
                style: colorsobj.styles(
                  color: const Color.fromARGB(255, 27, 88, 83),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Material(
            elevation: 8,
            color: Colors.transparent,
            shadowColor: const Color.fromARGB(255, 187, 251, 247),
            borderRadius: BorderRadius.circular(40),
            child: Container(
              height: height * 0.343,
              width: width * 0.866,
              decoration: BoxDecoration(
                gradient: colorsobj.colorsdark(),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ValueListenableBuilder(
                    valueListenable: transactionListNotifier,
                    builder: (BuildContext context,
                        List<TransactionModal> newlist, Widget? _) {
                      return newlist.isEmpty
                          ? Lottie.asset(
                              'assets/images/lottie/43191-no-data-error.json')
                          : ListView.builder(
                              itemBuilder: (BuildContext context, index) {
                                final values = newlist[index];
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      visiblity = false;
                                      Get.to(
                                        AddTransaction(
                                          index: index,
                                          modal: values,
                                        ),
                                        transition: Transition.zoom,
                                        duration: const Duration(
                                          milliseconds: 500,
                                        ),
                                      );
                                    });
                                  },
                                  
                                  child: obj.listTiles(
                                    context: context,
                                    amountColor:
                                        values.type == CategoryType.expense
                                            ? Colors.red
                                            : Colors.green,
                                    image: Image(
                                      image: AssetImage(
                                        values.type == CategoryType.income
                                            ? 'assets/images/icons/piggy-bank (1).png'
                                            : 'assets/images/icons/bankruptcy.png',
                                      ),
                                    ),
                                    title: values.category.name,
                                    subtitle: parseDate(values.date),
                                    amount: values.amount.toString(),
                                  ),
                                );
                              },
                              itemCount:
                                  newlist.length > 3 ? 3 : newlist.length,
                            );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }
}
