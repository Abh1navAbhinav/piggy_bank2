import 'package:cup_cake/modals/username_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

const userNamedbName = 'usernameDbName';

Future<void> addUsername(UsernameModal obj) async {
  final db = await Hive.openBox<UsernameModal>(userNamedbName);
  db.add(obj);
}

getUserName() async {
  final dB = await Hive.openBox<UsernameModal>(userNamedbName);
  userListNotifier.value = dB.values.toList()[0];
}

ValueNotifier<UsernameModal> userListNotifier = ValueNotifier(UsernameModal(username: ''));
Future<void> updateUserNameDb({required UsernameModal modal}) async {
  final dB = await Hive.openBox<UsernameModal>(userNamedbName);
  await dB.put(modal.id, modal);
  getUserName();
}
