// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:cup_cake/db/transaction_db.dart';
import 'package:cup_cake/functions/filteration.dart';
import 'package:cup_cake/functions/popups.dart';
import 'package:cup_cake/functions/scroll_behaviour.dart';
import 'package:cup_cake/modals/category_modal.dart';
import 'package:cup_cake/modals/transaction_modal.dart';
import 'package:cup_cake/screens/add_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../functions/colors_and_style.dart';
import '../functions/widgets.dart';

class AllTransaction extends StatefulWidget {
  const AllTransaction({Key? key}) : super(key: key);

  @override
  State<AllTransaction> createState() => _AllTransactionState();
}

class _AllTransactionState extends State<AllTransaction> {
  final obj = Widgets();
  final popupsobj = Popups();
  final colorsobj = Colours();

  String categoryId1 = 'All';
  String categoryId2 = 'All';

  var currentselecteditem1;
  var currentselecteditem2;

  @override
  void initState() {
    filterFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              borderRadius: BorderRadius.circular(50),
              shadowColor: const Color.fromARGB(255, 187, 251, 247),
              elevation: 8,
              child: Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                  gradient: colorsobj.colorsdark(),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'search Items',
                      hintStyle: colorsobj.styles(
                        color: Colors.grey,
                      ),
                      icon: const Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            obj.appLogo(),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 24,
              ),
              child: Material(
                shadowColor: const Color.fromARGB(255, 187, 251, 247),
                borderRadius: BorderRadius.circular(18),
                elevation: 10,
                child: Container(
                  height: 50,
                  width: 130,
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
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          value: categoryId1,
                          items: <String>[
                            'All',
                            'Income',
                            'Expense',
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
                              categoryId1 = value.toString();
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
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
                  height: 50,
                  width: 130,
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
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          value: categoryId2,
                          items: <String>[
                            'All',
                            'Today',
                            'Yesterday',
                            'Lastweek',
                            'Lastmonth',
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
          ],
        ),
        Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(21),
          shadowColor:  const Color.fromARGB(255, 187, 251, 247),
          child: Container(
            width: 312,
            height: 470,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21),
              
              gradient: colorsobj.colorsdark(),
            ),
            child: ValueListenableBuilder(
              valueListenable: listenFunction(),
              builder: (BuildContext context, List<TransactionModal> newlist,
                  Widget? _) {
                return newlist.isEmpty
                    ? Lottie.asset(
                        'assets/images/lottie/43191-no-data-error.json')
                    : ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, index) {
                            final values = newlist[index];
                            return Slidable(
                              key: Key(values.id!),
                              startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (ctx) {
                                      popupsobj.deleteTransactionPopup(
                                          context: ctx, list: values);
                                    },
                                    icon: Icons.delete,
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.transparent,
                                  )
                                ],
                              ),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (ctx) {
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
                                    icon: Icons.edit,
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.black,
                                  )
                                ],
                              ),
                              child: obj.listTiles(
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
                              ),
                            );
                          },
                          itemCount: newlist.length,
                        ),
                      );
              },
            ),
          ),
        ),
      ],
    );
  }

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }

  listenFunction() {
    if (categoryId1 == 'All' && categoryId2 == 'All') {
      return transactionListNotifier;
    } else if (categoryId1 == 'All' && categoryId2 == 'Today') {
      return todayNotifier;
    } else if (categoryId1 == 'All' && categoryId2 == 'Yesterday') {
      return yesterdayNotifier;
    } else if (categoryId1 == 'Income' && categoryId2 == 'All') {
      return incomeNotifier;
    } else if (categoryId1 == 'Income' && categoryId2 == 'Today') {
      return incomeTodayNotifier;
    } else if (categoryId1 == 'Income' && categoryId2 == 'Yesterday') {
      return incomeYesterdayNotifier;
    } else if (categoryId1 == 'Expense' && categoryId2 == 'All') {
      return expenseNotifier;
    } else if (categoryId1 == 'Expense' && categoryId2 == 'Today') {
      return expenseTodayNotifier;
    } else if (categoryId1 == 'Expense' && categoryId2 == 'Yesterday') {
      return expenseYesterdayNotifier;
    } else if (categoryId1 == 'All' && categoryId2 == 'Lastweek') {
      return lastWeekNotifier;
    } else if (categoryId1 == 'Expense' && categoryId2 == 'Lastweek') {
      return expenseLastWeekNotifier;
    } else if (categoryId1 == 'Income' && categoryId2 == 'Lastweek') {
      return incomeLastWeekNotifier;
    } else if (categoryId1 == 'All' && categoryId2 == 'Lastmonth') {
      return lastMonthNotifier;
    } else if (categoryId1 == 'Expense' && categoryId2 == 'Lastmonth') {
      return expenseLastMonthNotifier;
    } else if (categoryId1 == 'Income' && categoryId2 == 'Lastmonth') {
      return incomeLastMonthNotifier;
    }
  }
}
