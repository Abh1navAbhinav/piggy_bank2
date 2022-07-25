import 'package:cup_cake/functions/popups.dart';
import 'package:cup_cake/functions/uri_functions.dart';
import 'package:cup_cake/functions/widgets.dart';
import 'package:cup_cake/screens/about.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'notification.dart';

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

  @override
  void initState() {
    super.initState();
    NotificationApi.init(initSheduled: true);
    listennotification();
  }

  void listennotification() => NotificationApi.onNotification;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
              const SizedBox(
                width: 149,
              ),
              obj.appLogo(),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          obj.settingsitems(
            function: () {
              popupsobj.resetAppPopup(context: context);
            },
            icon: const Icon(
              Icons.refresh,
              color: Color.fromARGB(255, 27, 88, 83),
            ),
            text: 'Reset Piggy Bank',
          ),
          const SizedBox(
            height: 30,
          ),
          obj.settingsitems(
            function: () {
              widgetsobj.showbottomsheeet(context: context);
            },
            icon: const Icon(
              Icons.contact_page_outlined,
              color: Color.fromARGB(255, 27, 88, 83),
            ),
            text: 'Contact Me',
          ),
          const SizedBox(
            height: 30,
          ),
          obj.settingsitems(
            function: () {
              urifunctionsobj.emailUriFunction();
            },
            icon: const Icon(
              Icons.note_alt_outlined,
              color: Color.fromARGB(255, 27, 88, 83),
            ),
            text: 'Feed Back',
          ),
          const SizedBox(
            height: 30,
          ),
          obj.settingsitems(
            function: () async {
              final TimeOfDay? pickedtime = await showTimePicker(
                  initialEntryMode: TimePickerEntryMode.input,
                  context: context,
                  initialTime: time);
              if (pickedtime == null) return;
              setState(() {
                NotificationApi.showShedulednotification(
                  title: 'Hi Bilal',
                  body: 'Add your transaction',
                  payload: 'payload bilal',
                  sheduleddatetime: Time(
                    pickedtime.hour,
                    pickedtime.minute,
                    0,
                  ),
                );
                time = pickedtime;
              });
            },
            icon: const Icon(
              Icons.notifications_active_outlined,
              color: Color.fromARGB(255, 27, 88, 83),
            ),
            text: 'Remainder',
          ),
          const SizedBox(
            height: 30,
          ),
          obj.settingsitems(
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
          const SizedBox(
            height: 30,
          ),
          obj.settingsitems(
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
