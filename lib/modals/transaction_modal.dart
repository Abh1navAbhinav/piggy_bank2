import 'package:cup_cake/modals/category_modal.dart';
import 'package:hive/hive.dart';

part 'transaction_modal.g.dart';

@HiveType(typeId: 3)
class TransactionModal extends HiveObject{
  @HiveField(0)
   int amount;

  @HiveField(1)
   DateTime date;

  @HiveField(2)
   CategoryType type;

  @HiveField(3)
   CategoryModal category;

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
  updateTranscation(TransactionModal t){
    amount = t.amount;
    date = t.date;
    type = t.type;
    category = t.category;
    save();
  }
}
