import 'package:cup_cake/functions/popups.dart';
import 'package:cup_cake/functions/uri_functions.dart';
import 'package:cup_cake/functions/widgets.dart';
import 'package:cup_cake/screens/about.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final obj = Widgets();

  final popupsobj = Popups();

  final urifunctionsobj = Urifunction();

  final widgetsobj = Widgets();

  TimeOfDay time = TimeOfDay.now();
/* 
  @override
  void initState() {
    super.initState();
    NotificationApi.init(initSheduled: true);
    listennotification();
  }

  void listennotification() => NotificationApi.onNotification;
  onclikednotification() => Get.to(() => const BottomNav());
 */
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.settings_outlined,
                    color: Color.fromARGB(255, 27, 88, 83),
                    size: 30,
                  ),
                  Text(
                    '    Settings',
                    style: colorsobj.styles(
                      fontSize: 25,
                      color: const Color.fromARGB(255, 27, 88, 83),
                    ),
                  ),
                ],
              ),
              obj.appLogo(),
            ],
          ),
          SizedBox(
            height: height * 0.0657,
          ),
          obj.settingsitems(
            context: context,
            function: () {
              popupsobj.resetAppPopup(context: context);
            },
            icon: const Icon(
              Icons.refresh,
              color: Color.fromARGB(255, 27, 88, 83),
            ),
            text: 'Reset Piggy Bank',
          ),
          SizedBox(
            height: height * 0.039,
          ),
          obj.settingsitems(
            context: context,
            function: () {
              widgetsobj.showbottomsheeet(context: context);
            },
            icon: const Icon(
              Icons.contact_page_outlined,
              color: Color.fromARGB(255, 27, 88, 83),
            ),
            text: 'Contact Me',
          ),
          SizedBox(
            height: height * 0.039,
          ),
          obj.settingsitems(
            context: context,
            function: () {
              urifunctionsobj.emailUriFunction();
            },
            icon: const Icon(
              Icons.note_alt_outlined,
              color: Color.fromARGB(255, 27, 88, 83),
            ),
            text: 'Feed Back',
          ),
          SizedBox(
            height: height * 0.039,
          ),
          obj.settingsitems(
            context: context,
            function: () {
              Share.share('Piggy bank');
              /*  final TimeOfDay? pickedtime = await showTimePicker(
                  initialEntryMode: TimePickerEntryMode.input,
                  context: context,
                  initialTime: time);
              if (pickedtime == null) return;
              setState(() {
                NotificationApi.showShedulednotification(
                  title: 'Hi ${userListNotifier.value.username}',
                  body: 'Click on the notification to add transaction',
                  payload: 'payload ${userListNotifier.value.username}',
                  sheduleddatetime: Time(
                    pickedtime.hour,
                    pickedtime.minute,
                    0,
                  ),
                );
                time = pickedtime;
              }); */
            },
            icon: const Icon(
              Icons.share_outlined,
              color: Color.fromARGB(255, 27, 88, 83),
            ),
            text: 'Share',
          ),
          SizedBox(
            height: height * 0.039,
          ),
          obj.settingsitems(
            context: context,
            function: () {
              /* popupsobj.deleteAllTransactionPopup(
                context: context,
              ); */
              widgetsobj.showbottomsheeetDelete(context: context);
            },
            icon: const Icon(
              Icons.delete_outline,
              color: Color.fromARGB(255, 27, 88, 83),
            ),
            text: 'Delete',
          ),
          SizedBox(
            height: height * 0.039,
          ),
          obj.settingsitems(
            context: context,
            function: () {
              Get.to(
                () => const About(),
                transition: Transition.cupertinoDialog,
                duration: const Duration(
                  milliseconds: 800,
                ),
              );
            },
            icon: const Icon(
              Icons.info_outline,
              color: Color.fromARGB(255, 27, 88, 83),
            ),
            text: 'About',
          ),
        ],
      ),
    );
  }
}
