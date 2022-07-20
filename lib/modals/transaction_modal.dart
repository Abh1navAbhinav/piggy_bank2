import 'package:cup_cake/modals/category_modal.dart';
import 'package:hive/hive.dart';

part 'transaction_modal.g.dart';

@HiveType(typeId: 3)
class TransactionModal {
  @HiveField(0)
  final int amount;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final CategoryType type;

  @HiveField(3)
  final CategoryModal category;

  @HiveField(4)
  String? id;

  TransactionModal({
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
