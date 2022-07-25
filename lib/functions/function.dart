import 'package:cup_cake/functions/widgets.dart';
import 'package:cup_cake/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/category_db.dart';
import '../db/transaction_db.dart';
import '../db/username_db.dart';
import '../modals/category_modal.dart';
import '../modals/transaction_modal.dart';
import '../modals/username_modal.dart';

final widgetsobj = Widgets();

class Functions {
  showdialog(context, String text, int tabindex) {
    final textcontroller = TextEditingController();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: TextFormField(
            maxLength: 10,
            controller: textcontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: text,
              hintStyle: colorsobj.styles(color: Colors.grey),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                left: 200,
              ),
              child: IconButton(
                onPressed: () {
                  final category = CategoryModal(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: textcontroller.text,
                    type: tabindex == 0
                        ? CategoryType.income
                        : CategoryType.expense,
                  );
                  if (textcontroller.text.isEmpty) {
                    return Get.back();
                  }
                  categorydbs.insertCategory(category);
                  showSnackbarSuccess(
                      context: context,
                      text: "Category added succefully  ✓",
                      color: Colors.white,
                      textcolor: Colors.green,
                      visibility: false,
                      fontWeight: FontWeight.bold);
                  Get.back();
                },
                icon: const Icon(
                  Icons.check_circle_outline_rounded,
                  size: 30,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

////////////////////////////////////////////////////////////////////////////////////////////

  showSnackbarSuccess({
    required BuildContext context,
    required String text,
    Color color = Colors.white,
    Color textcolor = Colors.black,
    bool visibility = true,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 16,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: visibility,
              child: Text(
                'Warning:  ',
                style: colorsobj.styles(
                  color: Colors.red,
                ),
              ),
            ),
            Text(
              text,
              style: colorsobj.styles(
                color: textcolor,
                fontWeight: fontWeight,
              ),
            ),
            Visibility(
              visible: visibility,
              child: Text(
                '  ! ! !',
                style: colorsobj.styles(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////////////////

  resetApp() async {
    Get.offAll(
      const SplashScreen(),
    );
    final sharedpref = await SharedPreferences.getInstance();
    await sharedpref.clear();
    final categoryDb = await Hive.openBox<CategoryModal>(categoryDbName);
    categoryDb.clear();
    CategoryDb.instance.refreshUi();

    final transactiondB =
        await Hive.openBox<TransactionModal>(transactionDbName);
    transactiondB.clear();
    TransactionDb.instance.refresh();
    final userNamedb = await Hive.openBox<UsernameModal>(userNamedbName);
    userNamedb.clear();
  }

////////////////////////////////////////////////////////////////////////////////////////////

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

////////////////////////////////////////////////////////////////////////////////////////////

  editUserName(
    context,
    String text,
  ) {
    final usernamecontroller = TextEditingController();
    usernamecontroller.text = userListNotifier.value.username;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: TextFormField(
            maxLength: 15,
            controller: usernamecontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: text,
              hintStyle: colorsobj.styles(color: Colors.grey),
            ),
            style: colorsobj.styles(
              color: Colors.red,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                left: 200,
              ),
              child: IconButton(
                onPressed: () async {
                 userListNotifier.value.updateusername(usernamecontroller.text);
                  Get.back();
                },
                icon: const Icon(
                  Icons.check_circle_outline_rounded,
                  size: 30,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
