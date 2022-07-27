
import 'package:cup_cake/modals/transaction_modal.dart';

class ChartData {
  String categories;
  int amount;
  ChartData({required this.amount, required this.categories});
}

chartLogic(List<TransactionModal> model) {
  int value;
  String categoryname;
  List visited = [];
  List<ChartData> newData = [];

  for (var i = 0; i < model.length; i++) {
    visited.add(0);
  }
  for (var i = 0; i < model.length; i++) {
    value = model[i].amount;
    categoryname = model[i].category.name;
    for (var j = i + 1; j < model.length; j++) {
      if (model[i].category.name == model[j].category.name) {
        value += model[j].amount;
        visited[j] = -1;
      }
    }
    if (visited[i] != -1) {
      newData.add(ChartData(amount: value, categories: categoryname));
    }
  }
  return newData;
}