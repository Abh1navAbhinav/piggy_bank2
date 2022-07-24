// ignore_for_file: must_be_immutable

import 'package:cup_cake/functions/function.dart';
import 'package:cup_cake/functions/scroll_behaviour.dart';
import 'package:cup_cake/functions/widgets.dart';
import 'package:cup_cake/modals/category_modal.dart';
import 'package:cup_cake/modals/transaction_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../db/transaction_db.dart';
import '../functions/colors_and_style.dart';
import 'bottom_navigation.dart';

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
    return Column(
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
                        fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                   Text(
                    'username',
                    style: colorsobj.styles(
                      color: Colors.pink,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 75,
              ),
              obj.appLogo(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 20),
          child: Material(
            elevation: 5,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 150,
              width: 320,
              decoration: BoxDecoration(
                gradient: colorsobj.colorsdark(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 31,
                  ),
                  Text(
                    'Total Balance',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
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
                            ? const SizedBox(
                                height: 50,
                                width: 50,
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/piggy balance.png',
                                  ),
                                ),
                              )
                            : const SizedBox(
                                height: 40,
                                width: 40,
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/icons/piggy-bank (2).png',
                                  ),
                                ),
                              ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: 100,
                          height: 30,
                          child: FittedBox(
                            child: Text(
                              totalBalance == 0 ? '₹0.00' : '₹ $totalBalance',
                              style: colorsobj.styles(
                                fontSize: 23,
                                fontWeight: FontWeight.w500,
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
                flag: true,
                totalExpense: totalExpense,
                totalIncome: totalIncome),
            obj.incomeAndExpense(
              flag: false,
              totalExpense: totalExpense,
              totalIncome: totalIncome,
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 150, bottom: 5),
          child: Text(
            'Recent Transactions',
            style: colorsobj.styles(
              color: const Color.fromARGB(255, 27, 88, 83),
            ),
          ),
        ),
        Material(
          elevation: 5,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(40),
          child: Container(
            height: 270,
            width: 312,
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
                  builder: (BuildContext context, List<TransactionModal> newlist,
                      Widget? _) {
                    return newlist.isEmpty
                        ? Lottie.asset(
                            'assets/images/lottie/43191-no-data-error.json')
                        : ListView.builder(
                            itemBuilder: (BuildContext context, index) {
                              final values = newlist[index];
                              return obj.listTiles(
                                amountColor: values.type == CategoryType.expense
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
                              );
                            },
                            itemCount: newlist.length > 3 ? 3 : newlist.length,
                          );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }
}
