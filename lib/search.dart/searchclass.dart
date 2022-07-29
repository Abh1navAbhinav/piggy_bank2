// ignore_for_file: library_private_types_in_public_api

import 'package:cup_cake/db/transaction_db.dart';
import 'package:cup_cake/modals/category_modal.dart';
import 'package:cup_cake/modals/transaction_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../functions/widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final obj = Widgets();
  final List<TransactionModal> allTransaction = searchList;
  // This list holds the data for the list view
  List<TransactionModal> foundTransaction = [];
  @override
  initState() {
    // at the beginning, all users are shown
    foundTransaction = allTransaction;
    super.initState();
  }

  // This function i s called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<TransactionModal> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = allTransaction;
    } else {
      results = allTransaction
          .where((name) => name.category.name
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      foundTransaction = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              TextFormField(
            
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(

                    labelText: 'Search',
                    suffixIcon: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close))),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: foundTransaction.isNotEmpty
                    ? ListView.builder(
                        itemCount: foundTransaction.length,
                        itemBuilder: (context, index) => Card(
                          key: ValueKey(foundTransaction[index].id),
                          color: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                           child: obj.listTiles(
                                context: context,
                                amountColor: foundTransaction[index].type == CategoryType.expense
                                    ? Colors.red
                                    : Colors.green,
                                image: Image(
                                  image: AssetImage(
                                    foundTransaction[index].type == CategoryType.income
                                        ? 'assets/images/icons/piggy-bank (1).png'
                                        : 'assets/images/icons/bankruptcy.png',
                                  ),
                                ),
                                title: foundTransaction[index].category.name,
                                subtitle: parseDate(foundTransaction[index].date),
                                amount: foundTransaction[index].amount.toString(),
                              ),
                        ),
                      )
                    : const Text(
                        'No Songs found',
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }
}
