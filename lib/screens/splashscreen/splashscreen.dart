// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../constants/colors.dart';
import '../../constants/textstyle.dart';
import '../homepage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Login-SignUp/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    loadUp();
    super.initState();
  }

  Future<Timer> loadUp() async {
    return Timer(Duration(seconds: 10), onDoneLoading);
  }

  void onDoneLoading() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GreenishgDarkTheme['themeColorDark'],
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                opacity: 0.3,
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 180,
                width: 190,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/Accra Technical University.png"),
                )),
              ),
            ),
            Text(
              "SECURED GUARD APP",
              style: GoogleFonts.poppins(
                textStyle: kCompanyTitleText,
              ),
            ),
            Text(
              "ATU Guard App-Admin",
              style: GoogleFonts.poppins(
                textStyle: kCompanysubTitleText,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
                child: SpinKitDoubleBounce(
              color: Colors.white,
              size: 40.0,
            ))
          ],
        ),
      ),
    );
  }
}
