// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unnecessary_null_comparison, empty_catches

import 'package:atusecurityapp/screens/Login-SignUp/login.dart';
import 'package:atusecurityapp/screens/Login-SignUp/signup.dart';
import 'package:atusecurityapp/screens/home/dashboard.dart';
import 'package:atusecurityapp/userGuard/Auth/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/colors.dart';
import '../../constants/textstyle.dart';
import '../../widget/curledContainer.dart';
import '../../widget/custombutton.dart';
import '../../widget/formfieldbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  String? mail;
  String? password;
  TextEditingController _mailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;

  bool _isloading = false;
  bool isErr = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GreenishgDarkTheme['themeColorDark'],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Container(
                      margin: const EdgeInsets.only(top: 60),
                      width: 130,
                      height: 120,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/Accra Technical University.png")))),
                ),
                Center(
                  child: Text(
                    "SECURED GUARD APP",
                    style: GoogleFonts.poppins(
                      textStyle: kCompanyTitleText,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text(
                    "Select Option To Continue",
                    style: GoogleFonts.montserrat(
                      textStyle: kCompanysubTitleText,
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      SelectBtn(
                          nextPage: Login(),
                          btnMessage: "Continue As Guard",
                          imageUrl: "assets/guard.png"),
                      SizedBox(
                        height: 20,
                      ),
                      SelectBtn(
                          nextPage: LoginPage(),
                          btnMessage: "Continue As Admin",
                          imageUrl: "assets/security-1.png"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectBtn extends StatelessWidget {
  final String btnMessage, imageUrl;
  final Widget nextPage;

  const SelectBtn(
      {super.key,
      required this.btnMessage,
      required this.imageUrl,
      required this.nextPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: OutlinedButton(
          onPressed: () async {
            
            await Future.delayed(Duration(seconds: 2)).then(
                (value) => Get.to(nextPage, transition: Transition.downToUp));
          },
          child: Row(
            children: [
              Container(height: 40, width: 40, child: Image.asset(imageUrl)),
              SizedBox(
                width: 20,
              ),
              Center(
                child: Text(
                  btnMessage,
                  style: TextStyle(color: GreenishgDarkTheme['themeColorDark']),
                ),
              )
            ],
          )),
    );
  }
}
