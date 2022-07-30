import 'package:cup_cake/functions/function.dart';
import 'package:cup_cake/functions/popups.dart';
import 'package:cup_cake/functions/scroll_behaviour.dart';
import 'package:cup_cake/functions/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

import '../functions/colors_and_style.dart';
import '../modals/category_modal.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> with TickerProviderStateMixin {
  final obj = Widgets();
  final functionsobj = Functions();
  final popupsobj = Popups();
  final colorsobj = Colours();
  @override
  void initState() {
    categorydbs.refreshUi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TabController tabController = TabController(length: 2, vsync: this);
    return Container(
      decoration: BoxDecoration(
        gradient: colorsobj.colorslight(),
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                        ),
                      ),
                      Text(
                        'C a t e g o r i e s',
                        style: colorsobj.styles(),
                      ),
                      obj.appLogo(),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.0657,
                  ),
                  TabBar(
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide.none,
                    ),
                    controller: tabController,
                    labelStyle: colorsobj.styles(),
                    labelColor: const Color.fromARGB(255, 27, 88, 83),
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(
                        text: 'Income',
                      ),
                      Tab(
                        text: 'Expense',
                      ),
                    ],
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    shadowColor: const Color.fromARGB(255, 187, 251, 247),
                    elevation: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: colorsobj.colorsdark(),
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      width: width,
                      height: height * 0.526,
                      child: ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            ValueListenableBuilder(
                              valueListenable:
                                  categorydbs.incomeCategoryListNotifier,
                              builder: (BuildContext ctx,
                                  List<CategoryModal> newlist, Widget? _) {
                                return newlist.isEmpty
                                    ? Lottie.asset(
                                        'assets/images/lottie/43191-no-data-error.json')
                                    : GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                        ),
                                        itemBuilder: (
                                          BuildContext context,
                                          index,
                                        ) {
                                          return ListTile(
                                            title: GestureDetector(
                                              onDoubleTap: () {
                                                popupsobj.deleteCategoryPopUp(
                                                  context: context,
                                                  list: newlist[index],
                                                );
                                              },
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Text(
                                                  newlist[index].name,
                                                  style: colorsobj.styles(
                                                    color: const Color.fromARGB(
                                                        255, 27, 88, 83),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: newlist.length,
                                      );
                              },
                            ),
                            ValueListenableBuilder(
                              valueListenable: categorydbs.expenseCategoryList,
                              builder: (BuildContext ctx,
                                  List<CategoryModal> newlist, Widget? _) {
                                return newlist.isEmpty
                                    ? Lottie.asset(
                                        'assets/images/lottie/43191-no-data-error.json')
                                    : GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                        ),
                                        itemBuilder: (
                                          BuildContext context,
                                          index,
                                        ) {
                                          return ListTile(
                                            title: GestureDetector(
                                              onDoubleTap: () {
                                                popupsobj.deleteCategoryPopUp(
                                                  context: context,
                                                  list: newlist[index],
                                                );
                                              },
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Text(
                                                  newlist[index].name,
                                                  style: colorsobj.styles(
                                                    color: const Color.fromARGB(
                                                        255, 27, 88, 83),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: newlist.length,
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 200,
                    ),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(30),
                      shadowColor: const Color.fromARGB(255, 187, 251, 247),
                      child: Container(
                        height: height * 0.0657,
                        width: width * 0.375,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: colorsobj.colorsdark(),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (tabController.index == 0) {
                              final tabindex = tabController.index;

                              functionsobj.showdialog(
                                context,
                                'Add income Category:',
                                tabindex,
                              );
                            } else {
                              final tabindex = tabController.index;

                              functionsobj.showdialog(
                                context,
                                'Add expense Category:',
                                tabindex,
                              );
                            }
                          },
                          child: Text(
                            'Add',
                            style: colorsobj.styles(
                              color: Colors.green,
                            ),
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
    );
  }
}
