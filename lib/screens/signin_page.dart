// ignore_for_file: must_be_immutable

import 'package:cup_cake/db/category_db.dart';
import 'package:cup_cake/db/username_db.dart';
import 'package:cup_cake/functions/widgets.dart';
import 'package:cup_cake/main.dart';
import 'package:cup_cake/modals/username_modal.dart';

import 'package:cup_cake/screens/bottom_navigation.dart';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/transaction_db.dart';
import '../functions/colors_and_style.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  void initState() {
    TransactionDb.instance.refresh();
    CategoryDb.instance.refreshUi();

    super.initState();
  }

  final obj = Widgets();
  final colorsobj = Colours();
  

  final _usernameController = TextEditingController();
  final formkey = GlobalKey<FormState>();

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      obj.elevate(
                        elevations: 5,
                        radius: 5,
                        width: 291,
                        height: 49,
                        gradient: colorsobj.colorsdark(),
                        text: 'Welcome  to   Piggy Bank',
                        tpadding: 13,
                        lpadding: 17,
                      ),
                      SizedBox(
                        height: 300,
                        width: 500,
                        child: Lottie.asset(
                          'assets/images/lottie/107642-lost-in-the-metaverse.json',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Material(
                          elevation: 20,
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            height: 150,
                            width: 400,
                            decoration: BoxDecoration(
                              gradient: colorsobj.colorsdark(),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 20,
                                      bottom: 10,
                                    ),
                                    child: Text(
                                      'Enter your Name',
                                      style: colorsobj.styles(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      elevation: 5,
                                      child: Form(
                                        key: formkey,
                                        child: TextFormField(
                                          maxLength: 15,
                                          keyboardType: TextInputType.name,
                                          controller: _usernameController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'User name should not be empty';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            hintText: 'Name',
                                            hintStyle: colorsobj.styles(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          style: colorsobj.styles(
                                            fontWeight: FontWeight.w400,
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
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Material(
                            elevation: 20,
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: colorsobj.colorsdark(),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  checkLogin();
                                },
                                child: Text(
                                  'Log in',
                                  style: colorsobj.styles(
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future checkLogin() async {
    if (formkey.currentState!.validate()) {
      final sharedpref = await SharedPreferences.getInstance();
      await sharedpref.setBool(saveKeyName, true);

      Get.off(() => const BottomNav());
      final username = _usernameController.text.trim();
      final modal = UsernameModal(username: username);
      addUsername(modal);
    }

  }

}
