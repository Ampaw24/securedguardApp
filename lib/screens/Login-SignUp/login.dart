// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:atusecurityapp/screens/Login-SignUp/signup.dart';
import 'package:atusecurityapp/screens/home/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/colors.dart';
import '../../constants/textstyle.dart';
import '../../widget/curledContainer.dart';
import '../../widget/custombutton.dart';
import '../../widget/formfieldbox.dart';
import '../homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? mail;
  String? password;
  TextEditingController _mailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GreenishgDarkTheme['themeColorDark'],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Center(
                  child: Container(
                      margin: const EdgeInsets.only(top: 20),
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
                  height: 10,
                ),
                CurledContainer(
                  topleft: 68,
                  bottomright: 68,
                  boxheight: MediaQuery.of(context).size.height * 1.43,
                  boxwidth: 350,
                  color: GreenishgDarkTheme['cardWhite'],
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Text(
                          "Login",
                          style: GoogleFonts.abel(
                            textStyle: kLoginTextHead,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FormFieldBox(
                        controller: _mailcontroller,
                        prefixi: Icons.person,
                        hinttext: "Admin Id",
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FormFieldBox(
                        controller: _passwordcontroller,
                        prefixi: Icons.lock,
                        suffixi: Icons.remove_red_eye,
                        hinttext: "Enter Password",
                      ),
                      CustomButton1(
                        onpressed: () async {
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: _mailcontroller.text,
                                password: _passwordcontroller.text);
                            if (user != null) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Dashboard()));
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        buttonText: "Login",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage())),
                              child: Text("Create Account"))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
