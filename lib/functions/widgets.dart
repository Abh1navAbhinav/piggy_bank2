// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:cup_cake/db/category_db.dart';

import 'package:cup_cake/functions/function.dart';
import 'package:cup_cake/functions/uri_functions.dart';
import 'package:cup_cake/screens/about.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../modals/category_modal.dart';
import 'colors_and_style.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);
final categorydbs = CategoryDb();
final funtionsobj = Functions();
final colorsobj = Colours();
final urifunctionobj = Urifunction();

class Widgets {
  Widget listTiles({
    required Image image,
    required String title,
    required String subtitle,
    required String amount,
    required Color amountColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
      child: Row(
        children: [
          Material(
            elevation: 20,
            borderRadius: BorderRadius.circular(50),
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                // color:  const Color.fromARGB(255, 196, 245, 235),
                gradient: colorsobj.colorslight(),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  child: image,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Material(
            elevation: 20,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                // color:  const Color.fromARGB(255, 196, 245, 235),
                gradient: colorsobj.colorslight(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: colorsobj.styles(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: colorsobj.styles(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '₹ $amount',
                      style: colorsobj.styles(
                        color: amountColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Widget elevate({
    required double elevations,
    required double radius,
    required double width,
    required double height,
    required Gradient gradient,
    String text = '',
    double tpadding = 0,
    double bpadding = 0,
    double lpadding = 0,
    double rpadding = 0,
  }) {
    return Material(
      elevation: elevations,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: gradient,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: tpadding,
            left: lpadding,
            right: rpadding,
            bottom: bpadding,
          ),
          child: Text(
            text,
            style: colorsobj.styles(),
          ),
        ),
      ),
    );
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Widget appLogo({
    double radius = 20,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 1,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Color.fromARGB(255, 165, 152, 152),
              spreadRadius: 1,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: GestureDetector(
            onTap: () => Get.to(
              () => const About(),
              transition: Transition.cupertinoDialog,
              duration: const Duration(
                milliseconds: 800,
              ),
            ),
            child: CircleAvatar(
              radius: radius,
              backgroundImage: const AssetImage(
                'assets/images/piggy bank logo1.jpg',
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Widget settingsitems({required String text, required Icon icon, function}) {
    return Row(
      children: [
        Material(
          elevation: 20,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: colorsobj.colorsdark(),
            ),
            child: IconButton(
              onPressed: function,
              icon: icon,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Material(
          elevation: 20,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 60,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: colorsobj.colorsdark(),
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shadowColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: function,
              child: Text(
                text,
                style: colorsobj.styles(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Widget incomeAndExpense({
    required int totalIncome,
    required int totalExpense,
    required bool flag,
  }) {
    return Material(
      elevation: 5,
      color: Colors.transparent,
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
      child: Container(
        height: 55,
        width: 150,
        decoration: BoxDecoration(
          gradient: colorsobj.colorsdark(),
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: ClipRRect(
                  child: Image(
                    image: flag == true
                        ? const AssetImage(
                            'assets/images/icons/piggy-bank (1).png',
                          )
                        : const AssetImage(
                            'assets/images/icons/bankruptcy.png',
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 75,
              width: 100,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: FittedBox(
                  child: Text(
                    flag == true
                        ? (totalIncome == 0 ? '₹ 0.00' : '₹ $totalIncome')
                        : (totalExpense == 0 ? '₹ 0.00' : '₹ $totalExpense'),
                    style: colorsobj.styles(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  showbottomsheeet({required BuildContext context}) {
    return showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 200,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              gradient: colorsobj.colorslight(),
              // color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      final Uri url = Uri.parse('https://flutter.dev');
                      if (!await launchUrl(url)) {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(
                            'assets/images/socialMedia/photo-1611944212129-29977ae1398c.jpg',
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Contact me on LinkedIn',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 20,
                            color: const Color.fromARGB(255, 11, 90, 155),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      final Uri url = Uri.parse('https://flutter.dev');
                      if (!await launchUrl(url)) {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(
                            'assets/images/socialMedia/facebook-icon-logo-white-background-editable-vector-illustration-facebook-icon-logo-141051712.jpg',
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Contact me on FaceBook',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 20,
                            color: const Color.fromARGB(255, 11, 90, 155),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      final Uri url = Uri.parse('https://flutter.dev');
                      if (!await launchUrl(url)) {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(
                            'assets/images/socialMedia/instagram-6970242_960_720.jpg',
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Contact me on Instagram',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 20,
                            color: const Color.fromARGB(255, 11, 90, 155),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
