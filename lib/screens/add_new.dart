// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:cup_cake/db/category_db.dart';
import 'package:cup_cake/db/transaction_db.dart';
import 'package:cup_cake/functions/function.dart';
import 'package:cup_cake/functions/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../functions/colors_and_style.dart';
import '../modals/category_modal.dart';
import '../modals/transaction_modal.dart';
import 'bottom_navigation.dart';
import 'categories.dart';

bool visiblity = true;

class AddTransaction extends StatefulWidget {
  TransactionModal? modal;
  int? index;
  AddTransaction({
    Key? key,
    this.index,
    this.modal,
  }) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final obj = Widgets();
  final functionsogj = Functions();
  final colorsobj = Colours();
  Color colorgrey = Colors.black;

  var categoryId;

  DateTime? selectedDate;
  CategoryModal? selectedCategoryModal;
  CategoryType? selectedCategoryType;
  String? selectedCategoryitem;
  final amountController = TextEditingController();

  @override
  void initState() {
    selectedCategoryType = CategoryType.income;
    CategoryDb.instance.refreshUi();
    if (visiblity == false) {
      amountController.text = widget.modal!.amount.toString();

      selectedDate = widget.modal!.date;
      selectedCategoryType = widget.modal!.type;
      selectedCategoryitem = widget.modal!.category.name;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        gradient: colorsobj.colorslight(),
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight),
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
                          SizedBox(
                            height: height * 0.1315,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: Material(
                              elevation: 15,
                              borderRadius: BorderRadius.circular(30),
                              shadowColor:
                                  const Color.fromARGB(255, 187, 251, 247),
                              child: Container(
                                height: height * 0.1315,
                                width: width * 0.85,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: colorsobj.colorsdark(),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: width * 0.027,
                                    ),
                                    Material(
                                      borderRadius: BorderRadius.circular(18),
                                      shadowColor: const Color.fromARGB(
                                          255, 187, 251, 247),
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
                                        width: width * 0.472,
                                        height: height * 0.085,
                                        child: TextFormField(
                                          maxLength: 6,
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
                                            FilteringTextInputFormatter
                                                .digitsOnly
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
                              shadowColor:
                                  const Color.fromARGB(255, 187, 251, 247),
                              child: Container(
                                height: height * 0.3289,
                                width: width * 0.85,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: colorsobj.colorsdark(),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: height * 0.0526,
                                    ),
                                    Material(
                                      borderRadius: BorderRadius.circular(18),
                                      shadowColor: const Color.fromARGB(
                                          255, 187, 251, 247),
                                      elevation: 5,
                                      child: Container(
                                        height: height * 0.0789,
                                        width: width * 0.75,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
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
                                                        selectedCategoryitem =
                                                            'Items';
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
                                                            CategoryType
                                                                .expense;
                                                        categoryId = null;
                                                        selectedCategoryitem =
                                                            'Items';
                                                        colorgrey = Colors.red;
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
                                        shadowColor: const Color.fromARGB(
                                            255, 187, 251, 247),
                                        elevation: 5,
                                        child: Container(
                                          height: height * 0.0789,
                                          width: width * 0.75,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                DropdownButton<String>(
                                                  hint: Text(
                                                    visiblity == false
                                                        ? selectedCategoryitem!
                                                        : 'Items',
                                                    style: colorsobj.styles(
                                                      color: visiblity == true
                                                          ? Colors.grey
                                                          : colorgrey,
                                                    ),
                                                  ),
                                                  value: categoryId,
                                                  underline: const Divider(
                                                    color: Colors.transparent,
                                                  ),
                                                  style: colorsobj.styles(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  items: (selectedCategoryType ==
                                                              CategoryType
                                                                  .income
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
                                                        selectedCategoryModal =
                                                            e;
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
                                                      transition:
                                                          Transition.zoom,
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
                              shadowColor:
                                  const Color.fromARGB(255, 187, 251, 247),
                              child: Container(
                                height: height * 0.0657,
                                width: width * 0.33,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: colorsobj.colorsdark(),
                                ),
                                child: Visibility(
                                  visible: visiblity,
                                  replacement: TextButton.icon(
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
                                      'Update',
                                      style: colorsobj.styles(
                                        color: const Color.fromARGB(
                                            255, 27, 88, 83),
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
                                        color: const Color.fromARGB(
                                            255, 27, 88, 83),
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
      ),
    );
  }

  addTransactionFunction() async {
    final amountText = amountController.text;
    final parsedAmount = int.tryParse(amountText);

    if (amountText.isEmpty || parsedAmount == null) {
      return visiblity == true
          ? functionsogj.showSnackbarSuccess(
              elevation: 16,
              context: context,
              text: 'enter the amount',
            )
          : null;
    }
    if (amountText == '0') {
      return functionsogj.showSnackbarSuccess(
        elevation: 16,
        context: context,
        text: 'amount column is "0"',
      );
    }
    if (selectedCategoryModal == null || categoryId == null) {
      visiblity == true
          ? functionsogj.showSnackbarSuccess(
              elevation: 16,
              context: context,
              text: 'choose the item',
            )
          : null;
    }

    final model = TransactionModal(
      amount: parsedAmount,
      date: selectedDate ?? DateTime.now(),
      type: selectedCategoryType!,
      category: visiblity == false
          ? selectedCategoryModal = widget.modal!.category
          : selectedCategoryModal!,
    );

    visiblity == false
        ? widget.modal!.updateTranscation(model)
        : TransactionDb.instance.addTransactionDb(model);
    Get.offAll(
      () => const BottomNav(),
      transition: Transition.fade,
      duration: const Duration(
        milliseconds: 800,
      ),
    );
    setState(() {
      visiblity = true;
    });

    functionsogj.showSnackbarSuccess(
      elevation: 3,
      context: context,
      text: visiblity == false
          ? "Transaction updated succefully  ✓"
          : "Transaction added succefully  ✓",
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
