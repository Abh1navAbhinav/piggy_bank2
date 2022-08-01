// ignore_for_file: library_private_types_in_public_api

import 'package:cup_cake/db/transaction_db.dart';
import 'package:cup_cake/modals/transaction_modal.dart';
import 'package:cup_cake/screens/add_new.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../functions/widgets.dart';
import '../modals/category_modal.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController textcontrollerSearch = TextEditingController();
  final obj = Widgets();
  final List<TransactionModal> allTransaction = searchList;
  List<TransactionModal> foundTransaction = [];
  @override
  initState() {
    foundTransaction = allTransaction;
    TransactionDb.instance.refresh();
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<TransactionModal> results = [];

    if (enteredKeyword.isEmpty) {
      results = allTransaction;
    } else {
      results = allTransaction
          .where((name) => name.category.name
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      foundTransaction = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: colorsobj.colorsearch(),
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      controller: textcontrollerSearch,
                      // readOnly: foundTransaction.isEmpty ? true : false,
                      autofocus: foundTransaction.length < 3 ? false : true,
                      onChanged: (value) => _runFilter(value),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          labelText: foundTransaction.isEmpty
                              ? 'There is no transaction to search'
                              : 'Type an Item Name',
                          labelStyle: colorsobj.styles(
                              fontSize: 17, fontWeight: FontWeight.w500),
                          suffixIcon: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close))),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: foundTransaction.isNotEmpty
                        ? ListView.builder(
                            itemCount: foundTransaction.length,
                            itemBuilder: (context, index) => Card(
                              key: ValueKey(
                                foundTransaction[index].id,
                              ),
                              color: Colors.transparent,
                              shadowColor: Colors.transparent,
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: GestureDetector(
                                onTap: () {

                                  setState(() {
                                    FocusManager.instance.primaryFocus!.unfocus();
                                    visiblity = false;
                                    Get.to(
                                      () => AddTransaction(
                                        index: index,
                                        modal: foundTransaction[index],
                                      ),
                                      transition: Transition.zoom,
                                      duration: const Duration(
                                        milliseconds: 500,
                                      ),
                                    );
                                  });
                                },
                                onLongPress: () {
                                    popupsobj.deleteTransactionPopup(
                                      context: context,
                                      list: foundTransaction[index],
                                    );
                                  },
                                child: obj.listTiles(
                                  context: context,
                                  amountColor: foundTransaction[index].type ==
                                          CategoryType.expense
                                      ? Colors.red
                                      : Colors.green,
                                  image: Image(
                                    image: AssetImage(
                                      foundTransaction[index].type ==
                                              CategoryType.income
                                          ? 'assets/images/icons/piggy-bank (1).png'
                                          : 'assets/images/icons/bankruptcy.png',
                                    ),
                                  ),
                                  title: foundTransaction[index].category.name,
                                  subtitle:
                                      parseDate(foundTransaction[index].date),
                                  amount:
                                      foundTransaction[index].amount.toString(),
                                ),
                              ),
                            ),
                          )
                        : Lottie.asset(
                            'assets/images/lottie/lf20_iav9wojz.json',
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }
}
