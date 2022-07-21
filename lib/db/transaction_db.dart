// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:cup_cake/modals/transaction_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

const transactionDbName = 'transaction-db';
ValueNotifier<List<TransactionModal>> transactionListNotifier =
    ValueNotifier([]);

abstract class TransactionDbFunctions {
  Future<void> addTransactionDb(TransactionModal obj);
  Future<void> updateTransactionDb(index, value);
  Future<List<TransactionModal>> getAllTransactions();
  Future<void> deleteTransaction(String id);
}

class TransactionDb implements TransactionDbFunctions {
  TransactionDb._internal();
  static TransactionDb instance = TransactionDb._internal();

  factory TransactionDb() {
    return instance;
  }

  @override
  Future<void> addTransactionDb(TransactionModal obj) async {
    final dB = await Hive.openBox<TransactionModal>(transactionDbName);
    await dB.put(obj.id, obj);
  }

  Future<void> refresh() async {
    var list = await getAllTransactions();

    list = list.reversed.toList();

    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(list);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModal>> getAllTransactions() async {
    final dB = await Hive.openBox<TransactionModal>(transactionDbName);
    return dB.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final dB = await Hive.openBox<TransactionModal>(transactionDbName);
    await dB.delete(id);
    refresh();
  }
  
  @override
  Future<void> updateTransactionDb(index, value) async{
   final dB = await Hive.openBox<TransactionModal>(transactionDbName);
   await dB.put(index,value );
  }
  

}
