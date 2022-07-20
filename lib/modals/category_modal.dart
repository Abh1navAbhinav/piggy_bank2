import 'package:hive/hive.dart';
part 'category_modal.g.dart';

@HiveType(typeId: 2)
enum CategoryType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

@HiveType(typeId: 1)
class CategoryModal {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isDeleted;
  @HiveField(3)
  final CategoryType type;

  CategoryModal({
    required this.id,
    required this.name,
    required this.type,
    this.isDeleted = false,
  });
}
