// ignore_for_file: use_build_context_synchronously
import 'package:cup_cake/functions/colors_and_style.dart';
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
  final colorsobj = Colours();
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
    return Container(
      decoration: BoxDecoration(
        gradient: colorsobj.colorsearch(),
      ),
      child:   const Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.infinity,
              height: 200,
              child: Image(
                image: AssetImage('assets/images/splashscreen/Piggy bank 1.png'),
                fit: BoxFit.cover,
            
              ),
            ),
          ),
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
