// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cup_cake/db/category_db.dart';
import 'package:cup_cake/db/transaction_db.dart';
import 'package:cup_cake/functions/function.dart';
import 'package:cup_cake/functions/widgets.dart';
import 'package:cup_cake/screens/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../functions/colors_and_style.dart';
import '../modals/category_modal.dart';
import '../modals/transaction_modal.dart';

bool visiblity = true;

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final obj = Widgets();
  final functionsogj = Functions();
  final colorsobj = Colours();

  var categoryId;

  DateTime? selectedDate;
  CategoryModal? selectedCategoryModal;
  CategoryType? selectedCategoryType;

  final amountController = TextEditingController();

  @override
  void initState() {
    selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: colorsobj.colorslight(),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: viewportConstraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  visiblity = true;
                                });
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.arrow_back_rounded,
                              ),
                            ),
                            Text(
                              visiblity == true
                                  ? 'Add new Transaction'
                                  : 'Edit selected Transaction',
                              style: colorsobj.styles(),
                            ),
                            obj.appLogo(),
                          ],
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 20,
                          ),
                          child: Material(
                            elevation: 15,
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              height: 100,
                              width: 306,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: colorsobj.colorsdark(),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Material(
                                    borderRadius: BorderRadius.circular(18),
                                    elevation: 5,
                                    child: TextButton.icon(
                                      onPressed: () async {
                                        final selectedDateTemp =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now().subtract(
                                            const Duration(days: 30),
                                          ),
                                          lastDate: DateTime.now(),
                                        );
                                        if (selectedDateTemp == null) {
                                          return;
                                        } else {
                                          setState(() {
                                            selectedDate = selectedDateTemp;
                                          });
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.calendar_month_outlined,
                                      ),
                                      label: Text(
                                        selectedDate == null
                                            ? parseDate(
                                                DateTime.now(),
                                              ).toString()
                                            : parseDate(selectedDate!)
                                                .toString(),
                                        style: colorsobj.styles(),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15,
                                      top: 20,
                                    ),
                                    child: SizedBox(
                                      width: 170,
                                      height: 65,
                                      child: TextFormField(
                                        maxLength: 5,
                                        controller: amountController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          filled: true,
                                          fillColor: const Color.fromARGB(
                                              255, 234, 247, 248),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          hintText: 'Amount:',
                                          hintStyle: colorsobj.styles(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        style: colorsobj.styles(
                                          fontWeight: FontWeight.w400,
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 20,
                          ),
                          child: Material(
                            elevation: 15,
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              height: 250,
                              width: 306,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: colorsobj.colorsdark(),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Material(
                                    borderRadius: BorderRadius.circular(18),
                                    elevation: 5,
                                    child: Container(
                                      height: 60,
                                      width: 270,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        gradient: colorsobj.colorslight(),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              children: [
                                                Radio(
                                                  activeColor:
                                                      const Color.fromARGB(
                                                          255, 27, 88, 83),
                                                  value: CategoryType.income,
                                                  groupValue:
                                                      selectedCategoryType,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      selectedCategoryType =
                                                          CategoryType.income;
                                                      categoryId = null;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  'Income',
                                                  style: colorsobj.styles(),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  activeColor:
                                                      const Color.fromARGB(
                                                          255, 27, 88, 83),
                                                  value: CategoryType.expense,
                                                  groupValue:
                                                      selectedCategoryType,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      selectedCategoryType =
                                                          CategoryType.expense;
                                                      categoryId = null;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  'Expense',
                                                  style: colorsobj.styles(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 30,
                                      bottom: 24,
                                    ),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(18),
                                      elevation: 5,
                                      child: Container(
                                        height: 60,
                                        width: 270,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          gradient: colorsobj.colorslight(),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              DropdownButton<String>(
                                                hint: Text(
                                                  'Items',
                                                  style: colorsobj.styles(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                value: categoryId,
                                                underline: const Divider(
                                                  color: Colors.transparent,
                                                ),
                                                style: colorsobj.styles(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                items: (selectedCategoryType ==
                                                            CategoryType.income
                                                        ? CategoryDb()
                                                            .incomeCategoryListNotifier
                                                        : CategoryDb()
                                                            .expenseCategoryList)
                                                    .value
                                                    .map((e) {
                                                  return DropdownMenuItem(
                                                    value: e.id,
                                                    child: Text(e.name),
                                                    onTap: () {
                                                      selectedCategoryModal = e;
                                                    },
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    categoryId = value;
                                                  });
                                                },
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  Get.to(
                                                    () => const Categories(),
                                                    transition: Transition.zoom,
                                                    duration: const Duration(
                                                      milliseconds: 500,
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.add_circle_outline,
                                                  color: Color.fromARGB(
                                                      255, 27, 88, 83),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 180,
                          ),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 50,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: colorsobj.colorsdark(),
                              ),
                              child: Visibility(
                                visible: visiblity,
                                replacement: TextButton.icon(
                                  onPressed: () {
                                    Get.back();

                                    setState(() {
                                      visiblity = true;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.check_circle_outline_rounded,
                                    size: 25,
                                    color: Color.fromARGB(255, 27, 88, 83),
                                  ),
                                  label: Text(
                                    'Update',
                                    style: colorsobj.styles(
                                      color:
                                          const Color.fromARGB(255, 27, 88, 83),
                                    ),
                                  ),
                                ),
                                child: TextButton.icon(
                                  onPressed: () {
                                    addTransactionFunction();

                                    TransactionDb.instance.refresh();
                                  },
                                  icon: const Icon(
                                    Icons.check_circle_outline_rounded,
                                    size: 25,
                                    color: Color.fromARGB(255, 27, 88, 83),
                                  ),
                                  label: Text(
                                    'Submit',
                                    style: colorsobj.styles(
                                      color:
                                          const Color.fromARGB(255, 27, 88, 83),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  addTransactionFunction() async {
    final amountText = amountController.text;
    final parsedAmount = int.tryParse(amountText);

    if (amountText.isEmpty || parsedAmount == null) {
      return functionsogj.showSnackbarSuccess(
        context: context,
        text: 'enter the amount',
      );
    }
    if (selectedCategoryModal == null || categoryId == null) {
      return functionsogj.showSnackbarSuccess(
        context: context,
        text: 'choose the item',
      );
    }
    final model = TransactionModal(
      amount: parsedAmount,
      date: selectedDate ?? DateTime.now(),
      type: selectedCategoryType!,
      category: selectedCategoryModal!,
    );
    TransactionDb.instance.addTransactionDb(model);
    Get.back();

    functionsogj.showSnackbarSuccess(
      context: context,
      text: "Transaction added succefully  ✓",
      color: Colors.white,
      textcolor: Colors.green,
      visibility: false,
      fontWeight: FontWeight.bold,
    );
  }

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }
}
