// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, missing_required_param, prefer_final_fields

import 'dart:convert';

import 'package:atusecurityapp/selectionpage.dart';
import 'package:atusecurityapp/userGuard/specs/buttomNavBar.dart';
import 'package:atusecurityapp/userGuard/specs/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Register/register.dart';
import '../../config/firebase/firebaseAuth.dart';
import '../../config/firebase/firebaseProfile.dart';
import '../../config/sharePreference.dart';
import '../../specs/password_field.dart';
import '../../specs/text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

FireAuth _fireAuth = FireAuth();
FireProfile _fireProfile = FireProfile();
final _studentIdController = TextEditingController();
final _passwordController = TextEditingController();
bool _isLoading = false;

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void _showPasswordMismatchSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Passwords do not match'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showStudentIdNotFoundSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Wrong Student ID'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showRegistrationSuccessfulSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Login Successful'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Get.to(SelectPage()), child: Icon(Icons.arrow_back)),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                width: 300,
                height: 200,
                margin: EdgeInsets.all(20),
                child: Image.asset(
                  'assets/log.jpg',
                ),
              ),
              if (_isLoading)
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: BLUEBLACK,
                    ),
                  ),
                ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    margin: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: DARKBLUE),
                    ),
                  ),
                  Text("")
                ],
              ),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: textFormField(
                    hintText: "Guard Username",
                    borderWidth: 2,
                    validateMsg: "Field required",
                    borderRadius: 10,
                    controller: _studentIdController,
                    labelStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                    ),
                    keyboardType: TextInputType.name,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.singleLineFormatter,
                    ]),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.all(10),
                child: PasswordField(
                  hintText: "Password",
                  borderWidth: 2,
                  borderRadius: 10,
                  removeBorder: true,
                  validateMsg: "Field required",
                  controller: _passwordController,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0, top: 5),
                    child: GestureDetector(
                      onTap: () {
                        _showForgotPasswordModal(context);
                      },
                      child: Text(
                        "Forgotten Password",
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  setState(() {
                    _isLoading = true;
                  });

                  try {
                    UserCredential userCredential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email:
                          "${_studentIdController.text.trim()}@securityatu.com",
                      password: _passwordController.text,
                    );

                    // Login successful
                    _showRegistrationSuccessfulSnackbar();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BTMnav(
                                  pageIndex: 0,
                                )));
                  } catch (e) {
                    // Login failed
                    if (e is FirebaseAuthException) {
                      if (e.code == 'user-not-found') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Wrong Credentials'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (e.code == 'wrong-password') {
                        _showPasswordMismatchSnackbar();
                      }
                    } else {
                      print(e.toString());
                    }
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
                child: Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DARKBLUE,
                  ),
                  child: Center(
                      child: Text(
                    "Sign in",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: WHITE),
                  )),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, top: 5),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't have an account?\t\t",
                            style: GoogleFonts.roboto(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign up',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Register()));
                              },
                          ),
                          TextSpan(
                            text: '.',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showForgotPasswordModal(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Forgot Password'),
          message: Text('Please enter your email to reset your password:'),
          actions: [
            CupertinoTextField(
              controller: _studentIdController,
              placeholder: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            CupertinoButton(
              child: Text('Submit'),
              onPressed: () async {
                String email = _studentIdController.text.trim();
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: Text('Password Reset Requested'),
                      content: Text(
                        'A password reset email has been sent to $email. Please check your inbox to reset your password.',
                      ),
                      actions: [
                        CupertinoDialogAction(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        );
      },
    );
  }
}
