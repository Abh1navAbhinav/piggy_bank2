import 'package:cup_cake/functions/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

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
    TabController tabController = TabController(length: 2, vsync: this);

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
                      'About',
                      style: colorsobj.styles(fontSize: 30,fontWeight: FontWeight.w500),
                    ),
                    obj.appLogo(),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                TabBar(
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide.none,
                  ),
                  controller: tabController,
                  labelStyle: colorsobj.styles(),
                  labelColor: const Color.fromARGB(255, 27, 88, 83),
                  unselectedLabelColor: Colors.grey[400],
                  tabs: const [
                    Tab(
                      text: 'PiggyBank',
                    ),
                    Tab(
                      text: 'Developer',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
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
                      height: 400,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          Text(
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                            style: colorsobj.styles(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                            style: colorsobj.styles(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
