// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'screens/splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Security App',
      theme: ThemeData(
        dialogTheme: DialogTheme(backgroundColor: Colors.white),
        datePickerTheme:
            DatePickerThemeData(backgroundColor: Color(0xff13262E)),
        timePickerTheme: TimePickerThemeData(
            backgroundColor: Colors.white,
            hourMinuteColor: Color(0xff13262E),
            hourMinuteTextColor: Colors.white,
            dialHandColor: Color(0xff13262E)),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
