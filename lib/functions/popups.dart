import 'package:cup_cake/db/category_db.dart';
import 'package:cup_cake/functions/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';

import '../db/transaction_db.dart';
import '../modals/category_modal.dart';
import '../modals/transaction_modal.dart';

final stylesobj = Widgets();

class Popups {
  deleteCategoryPopUp({
    required context,
    required CategoryModal? list,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete',
            style: colorsobj.styles(),
          ),
          content: Text(
            'Selected category will be deleted permanently',
            style: colorsobj.styles(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'Cancel',
                style: colorsobj.styles(
                  color: Colors.green,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                categorydbs.deleteCategory(list!.id);
                funtionsobj.showSnackbarSuccess(
                  context: context,
                  text: "Category deleted succefully  ✓",
                  color: Colors.white,
                  textcolor: Colors.green,
                  visibility: false,
                  fontWeight: FontWeight.bold,
                );

                Get.back();
              },
              child: Text(
                'Delete',
                style: colorsobj.styles(
                  color: Colors.red,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

///////////////////////////////////////////////////////////////////////

  deleteTransactionPopup({
    required context,
    required TransactionModal list,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete',
            style: colorsobj.styles(),
          ),
          content: Text(
            'Selected transaction will be deleted permanently',
            style: colorsobj.styles(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'Cancel',
                style: colorsobj.styles(
                  color: Colors.green,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                TransactionDb.instance.deleteTransaction(
                  list.id!,
                );
                funtionsobj.showSnackbarSuccess(
                  context: context,
                  text: "Transaction deleted succefully  ✓",
                  color: Colors.white,
                  textcolor: Colors.green,
                  visibility: false,
                  fontWeight: FontWeight.bold,
                );

                Get.back();
              },
              child: Text(
                'Delete',
                style: colorsobj.styles(
                  color: Colors.red,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

///////////////////////////////////////////////////////////////////////

  deleteAllTransactionPopup({
    required context,
    required String text,
    required String snackbarText,
    required Box db,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete',
            style: colorsobj.styles(),
          ),
          content: Text(
            text,
            style: colorsobj.styles(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'Cancel',
                style: colorsobj.styles(
                  color: Colors.green,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                final dB = db;
                await dB.clear();
                Get.back();
                Get.back();
                TransactionDb.instance.refresh();
                CategoryDb.instance.refreshUi();
                funtionsobj.showSnackbarSuccess(
                  context: context,
                  text: /* "Transactions deleted succefully  ✓" */ snackbarText,
                  color: Colors.white,
                  textcolor: Colors.green,
                  visibility: false,
                  fontWeight: FontWeight.bold,
                );
              },
              child: Text(
                'Delete',
                style: colorsobj.styles(
                  color: Colors.red,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

///////////////////////////////////////////////////////////////////////

  resetAppPopup({
    required context,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Warning !!!',
            style: colorsobj.styles(
              color: Colors.red,
            ),
          ),
          content: Text(
            'The app\'s data will be permanently deleted. This includes files, settings, databases and other app data.',
            style: colorsobj.styles(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'Cancel',
                style: colorsobj.styles(
                  color: Colors.green,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                funtionsobj.resetApp();
                Get.back();
                /* funtionsobj.showSnackbarSuccess(
                  context: context,
                  text: "Piggy Bank resetted succefully  ✓",
                  color: Colors.white,
                  textcolor: Colors.green,
                  visibility: false,
                  fontWeight: FontWeight.bold,
                ); */
              },
              child: Text(
                'Confirm Reset',
                style: colorsobj.styles(
                  color: Colors.red,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

///////////////////////////////////////////////////////////////////////

}
