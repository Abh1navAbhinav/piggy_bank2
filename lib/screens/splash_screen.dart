// ignore_for_file: use_build_context_synchronously
import 'package:cup_cake/main.dart';
import 'package:cup_cake/screens/bottom_navigation.dart';
import 'package:cup_cake/screens/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/category_db.dart';
import '../db/transaction_db.dart';
import '../db/username_db.dart';
import '../functions/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkUserLoggedIn();

    CategoryDb.instance.refreshUi();
    TransactionDb.instance.refresh();
    getUserName();

    super.initState();
  }

  final obj = Widgets();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Piggy Bank.',
              style: colorsobj.styles(
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 10,
                  ),
                  child: obj.appLogo(
                    radius: 20,
                  ),
                ),
                Text(
                  'Piggy Bank',
                  style: colorsobj.styles(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> goToSignIn() async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    Get.off(
      () => const SigninPage(),
      transition: Transition.fade,
      duration: const Duration(
        milliseconds: 800,
      ),
    );
  }

  Future<void> checkUserLoggedIn() async {
    final sharedpref = await SharedPreferences.getInstance();
    final userloggedin = sharedpref.getBool(saveKeyName);
    if (userloggedin == null || userloggedin == false) {
      goToSignIn();
    } else {
      await Future.delayed(
        const Duration(
          seconds: 2,
        ),
      );
      Get.off(
        () => const BottomNav(),
        transition: Transition.fade,
        duration: const Duration(
          milliseconds: 800,
        ),
      );
    }
  }
}
