import 'package:cup_cake/functions/scroll_behaviour.dart';
import 'package:cup_cake/functions/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../db/username_db.dart';
import '../functions/colors_and_style.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> with TickerProviderStateMixin {
  final obj = Widgets();
  final colorsobj = Colours();
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        gradient: colorsobj.colorslight(),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                      ),
                    ),
                    Text(
                      'A b o u t',
                      style: colorsobj.styles(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    obj.appLogo(),
                  ],
                ),
                SizedBox(
                  height: height * 0.131,
                ),
                TabBar(
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide.none,
                  ),
                  controller: tabController,
                  labelStyle: colorsobj.styles(fontSize: 18),
                  labelColor: const Color.fromARGB(255, 27, 88, 83),
                  unselectedLabelColor: Colors.grey[400],
                  tabs: const [
                    Tab(
                      text: 'App',
                    ),
                    Tab(
                      text: 'Developer',
                    ),
                    Tab(
                      text: 'Read Me',
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.0263,
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    shadowColor: Colors.blue,
                    elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.all(
                        20,
                      ),
                      decoration: BoxDecoration(
                        gradient: colorsobj.colorsdark(),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: double.maxFinite,
                      height: height * 0.526,
                      child: ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            ListView(
                              children: [
                                Text(
                                  'Hi ${userListNotifier.value.username},\n\nwelcome to piggy bank. Piggy bank will help you take your budget, money and finance under control and won\'t take much time. you won\'t need to dig through your wallet or check your bank account to be aware of your financial circumstances. Piggy bank is very easy to use: you can quickly add a transaction with just a couple of clicks.We are trying to improve our app, If you have any suggestions, you can inform me by clicking the feed back section in settings, We will try to make piggy bank more better, Thank you.',
                                  style: colorsobj.styles(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    // letterSpacing: 0.5,
                                    // wordSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Text(
                                'I am Abhinav. Expertised in UI/UX Designing and Flutter development based on Kerala, If you have any queries related to piggy bank or about me you can contact me by taping \'Contact Me\' on the settings.Once of all thank you for supporting me.',
                                style: colorsobj.styles(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Center(
                              child: ListView(
                                children: [
                                  Text(
                                    'There are some features that you may not know.\n\n\n\n1. Tap on the app icons to navigate to About.\n\n2. Click on your name in HomePage to edit your name.\n\n3. Tap on the transaction to edit (on HomePage & Search Screen)\n\n4. Slide to left or right to edit and delete (on Second Page).',
                                    style: colorsobj.styles(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Text(
                  'version 1.0.0',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
