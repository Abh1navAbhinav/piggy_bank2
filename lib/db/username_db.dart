 import 'package:cup_cake/modals/username_modal.dart';
import 'package:hive_flutter/hive_flutter.dart';

const userNamedbName = 'usernameDbName';

  Future <void> addUsername(UsernameModal obj) async{
    final db =await Hive.openBox<UsernameModal>(userNamedbName);
    db.add(obj);
  }
