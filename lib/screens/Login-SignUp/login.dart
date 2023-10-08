// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unnecessary_null_comparison, empty_catches

import 'package:atusecurityapp/screens/Login-SignUp/signup.dart';
import 'package:atusecurityapp/screens/home/dashboard.dart';
import 'package:atusecurityapp/selectionpage.dart';
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

  bool _isloading = false;
  bool isErr = false;

  void _signInwithMail() async {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    setState(() {
      _isloading = true;
    });
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: "${_mailcontroller.text.trim()}@scmatu.com",
          password: _passwordcontroller.text);
      if (user != null) {
        Future.delayed(
            Duration(
              seconds: 20,
            ),
            () => Get.to(Dashboard(username: _mailcontroller.text)));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          _isloading = false;
          isErr = true;
          _mailcontroller.text = "";
        });
      } else if (e.code == "account-exists-with-different-credential") {
        setState(() {
          _isloading = false;
        });
      } else if (e.code == 'invalid-email') {
        setState(() {
          _isloading = false;
        });
      } else {
        setState(() {
          _isloading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isloading = false;
      });
    }
  }

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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CurledContainer(
                    topleft: 68,
                    bottomright: 68,
                    boxheight: MediaQuery.of(context).size.height * 1.30,
                    boxwidth: 300,
                    color: GreenishgDarkTheme['cardWhite'],
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: Text(
                            "Login",
                            style: GoogleFonts.montserrat(
                              textStyle: kLoginTextHead,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FormFieldBox(
                          errcolor: isErr
                              ? Color.fromARGB(255, 222, 40, 40)
                              : Colors.white,
                          controller: _mailcontroller,
                          prefixi: Icons.person,
                          hinttext: isErr ? "Invalid Admin Id" : "Admin Id",
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FormFieldBox(
                          errcolor: isErr
                              ? Color.fromARGB(255, 222, 40, 40)
                              : Colors.white,
                          controller: _passwordcontroller,
                          prefixi: Icons.lock,
                          suffixi: Icons.remove_red_eye,
                          hinttext: "Enter Password",
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomButton1(
                            onpressed: _signInwithMail,
                            buttonText: "Login",
                          ),
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
                        ),
                        GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectPage())),
                            child: Text("Go Back")),
                        _isloading
                            ? SpinKitDualRing(
                                size: 40,
                                color: Color(0xff13262E),
                              )
                            : Container()
                      ],
                    ),
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
