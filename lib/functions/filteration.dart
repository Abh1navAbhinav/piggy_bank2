// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:cup_cake/db/transaction_db.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../modals/category_modal.dart';
import '../modals/transaction_modal.dart';

final transactiondObj = TransactionDb();

ValueNotifier<List<TransactionModal>> incomeNotifier = ValueNotifier([]);

ValueNotifier<List<TransactionModal>> expenseNotifier = ValueNotifier([]);

ValueNotifier<List<TransactionModal>> todayNotifier = ValueNotifier([]);

ValueNotifier<List<TransactionModal>> yesterdayNotifier = ValueNotifier([]);

ValueNotifier<List<TransactionModal>> incomeTodayNotifier = ValueNotifier([]);

ValueNotifier<List<TransactionModal>> incomeYesterdayNotifier =
    ValueNotifier([]);

ValueNotifier<List<TransactionModal>> expenseTodayNotifier = ValueNotifier([]);

ValueNotifier<List<TransactionModal>> expenseYesterdayNotifier =
    ValueNotifier([]);
ValueNotifier<List<TransactionModal>> lastWeekNotifier = ValueNotifier([]);

ValueNotifier<List<TransactionModal>> incomeLastWeekNotifier =
    ValueNotifier([]);

ValueNotifier<List<TransactionModal>> expenseLastWeekNotifier =
    ValueNotifier([]);

ValueNotifier<List<TransactionModal>> lastMonthNotifier = ValueNotifier([]);

ValueNotifier<List<TransactionModal>> incomeLastMonthNotifier =
    ValueNotifier([]);

ValueNotifier<List<TransactionModal>> expenseLastMonthNotifier =
    ValueNotifier([]);

String today = DateFormat.yMd().format(
  DateTime.now(),
);
String yesterday = DateFormat.yMd().format(
  DateTime.now().subtract(
    const Duration(days: 1),
  ),
);

String lastWeek = DateFormat.yMd().format(
  DateTime.now().subtract(
    const Duration(days: 7),
  ),
);

String lastMonth = DateFormat.yMd().format(
  DateTime.now().subtract(
    const Duration(days: 30),
  ),
);

filterFunction() async {
  final list = await transactiondObj.getAllTransactions();

  incomeNotifier.value.clear();
  expenseNotifier.value.clear();
  todayNotifier.value.clear();
  yesterdayNotifier.value.clear();
  incomeTodayNotifier.value.clear();
  incomeYesterdayNotifier.value.clear();
  expenseTodayNotifier.value.clear();
  expenseYesterdayNotifier.value.clear();
  lastWeekNotifier.value.clear();
  expenseLastWeekNotifier.value.clear();
  incomeLastWeekNotifier.value.clear();
  lastMonthNotifier.value.clear();
  expenseLastMonthNotifier.value.clear();
  incomeLastMonthNotifier.value.clear();

  for (var element in list) {
    if (element.type == CategoryType.income) {
      incomeNotifier.value.add(element);
    } else if (element.type == CategoryType.expense) {
      expenseNotifier.value.add(element);
    }
  }

  for (var element in list) {
    String elementDate = DateFormat.yMd().format(element.date);
    if (elementDate == today) {
      todayNotifier.value.add(element);
    }

    if (elementDate == yesterday) {
      yesterdayNotifier.value.add(element);
    }
    if (elementDate == lastWeek) {
      lastWeekNotifier.value.add(element);
    }

    if (elementDate == lastMonth) {
      lastMonthNotifier.value.add(element);
    }

    if (elementDate == today && element.type == CategoryType.income) {
      incomeTodayNotifier.value.add(element);
    }

    if (elementDate == yesterday && element.type == CategoryType.income) {
      incomeYesterdayNotifier.value.add(element);
    }

    if (elementDate == today && element.type == CategoryType.expense) {
      expenseTodayNotifier.value.add(element);
    }

    if (elementDate == yesterday && element.type == CategoryType.expense) {
      expenseYesterdayNotifier.value.add(element);
    }
    if (elementDate == lastWeek && element.type == CategoryType.income) {
      incomeLastWeekNotifier.value.add(element);
    }

    if (elementDate == lastWeek && element.type == CategoryType.expense) {
      expenseLastWeekNotifier.value.add(element);
    }

    if (elementDate == lastMonth && element.type == CategoryType.income) {
      incomeLastMonthNotifier.value.add(element);
    }

    if (elementDate == lastMonth && element.type == CategoryType.expense) {
      expenseLastMonthNotifier.value.add(element);
    }
  }

  todayNotifier.notifyListeners();
  yesterdayNotifier.notifyListeners();
  incomeNotifier.notifyListeners();
  expenseNotifier.notifyListeners();
  incomeTodayNotifier.notifyListeners();
  incomeYesterdayNotifier.notifyListeners();
  expenseTodayNotifier.notifyListeners();
  expenseYesterdayNotifier.notifyListeners();
  lastWeekNotifier.notifyListeners();
  incomeLastWeekNotifier.notifyListeners();
  expenseLastWeekNotifier.notifyListeners();
  lastMonthNotifier.notifyListeners();
  incomeLastMonthNotifier.notifyListeners();
  expenseLastMonthNotifier.notifyListeners();
}
