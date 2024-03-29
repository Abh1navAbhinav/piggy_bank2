import 'package:cup_cake/modals/category_modal.dart';
import 'package:cup_cake/modals/transaction_modal.dart';
import 'package:cup_cake/modals/username_modal.dart';

import 'package:cup_cake/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/adapters.dart';

const saveKeyName = 'User logged in';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModalAdapter().typeId)) {
    Hive.registerAdapter(CategoryModalAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModalAdapter().typeId)) {
    Hive.registerAdapter(TransactionModalAdapter());
  }
  if (!Hive.isAdapterRegistered(UsernameModalAdapter().typeId)) {
    Hive.registerAdapter(UsernameModalAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color.fromARGB(255, 27, 88, 83),
            ),
      ),
      home: const SplashScreen(),
    );
  }
}
