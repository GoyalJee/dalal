import 'package:dalal/constants/my_colors.dart';
import 'package:dalal/views/home/user_home_view.dart';
import 'package:dalal/views/signup/who_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MyColors().createMaterialColor(MyColors.primary),
        scaffoldBackgroundColor: MyColors.light
      ),
      home: GetStorage().read('isOnBoardingScreenShowed') == 'true'
          ? UserHomeView()
          : WhoView(),
    );
  }
}
