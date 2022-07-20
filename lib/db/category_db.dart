// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:cup_cake/modals/category_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

const categoryDbName = 'category-database';

abstract class CategoryDbFucntions {
  Future<List<CategoryModal>> getCategories();
  Future<void> insertCategory(CategoryModal value);
  Future<void> deleteCategory(String categoryId);
}

class CategoryDb implements CategoryDbFucntions {
  CategoryDb.interal();
  static CategoryDb instance = CategoryDb.interal();
  factory CategoryDb() {
    return instance;
  }

  ValueNotifier<List<CategoryModal>> incomeCategoryListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModal>> expenseCategoryList = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModal value) async {
    final categoryDb = await Hive.openBox<CategoryModal>(categoryDbName);
    await categoryDb.put(value.id, value);
    refreshUi();
  }

  @override
  Future<List<CategoryModal>> getCategories() async {
    final categoryDb = await Hive.openBox<CategoryModal>(categoryDbName);
    return categoryDb.values.toList();
  }

  Future<void> refreshUi() async {
    final allCategories = await getCategories();
    incomeCategoryListNotifier.value.clear();
    expenseCategoryList.value.clear();
    await Future.forEach(
      allCategories,
      (CategoryModal category) {
        if (category.type == CategoryType.income) {
          incomeCategoryListNotifier.value.add(category);
        } else {
          expenseCategoryList.value.add(category);
        }
      },
    );
    incomeCategoryListNotifier.notifyListeners();
    expenseCategoryList.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    final categoryDb = await Hive.openBox<CategoryModal>(categoryDbName);
    await categoryDb.delete(categoryId);
    refreshUi();
  }
}
