// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, missing_required_param

import 'package:atusecurityapp/userGuard/Auth/Login/login.dart';
import 'package:atusecurityapp/userGuard/specs/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/postsites/postsites.dart';
import '../../config/firebase/firebaseAuth.dart';
import '../../specs/password_field.dart';
import '../../specs/text_field.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

final FireAuth _fireAuth = FireAuth();
DatabaseReference ref = FirebaseDatabase.instance.reference();

final _nameController = TextEditingController();
final _studentIdController = TextEditingController();
final _passwordController = TextEditingController();
final _confirmPasswordController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool _isLoading = false;

class _RegisterState extends State<Register> {
  void _showPasswordMismatchSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Passwords do not match'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showStudentIdFormatSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Student ID should be in the format: 0222220D'),
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
        content: Text('Registration Successful'),
        backgroundColor: Colors.green,
      ),
    );
  }

  bool isStudentIdValid(String value) {
    RegExp studentIdPattern = RegExp(r'^[0-9]{7}[A-Za-z]$');

    return studentIdPattern.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                width: 300,
                height: 200,
                margin: EdgeInsets.all(10),
                child: Image.asset(
                  'assets/regis.jpg',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: DARKBLUE),
                    ),
                  ),
                  Text("")
                ],
              ),

              _isLoading
                  ? CircularProgressIndicator(
                      color: GREEN,
                      strokeWidth: 4.0,
                    )
                  : SizedBox(height: 5),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: textFormField(
                    hintText: "Full name",
                    borderWidth: 2,
                    validateMsg: "Field required",
                    borderRadius: 10,
                    controller: _nameController,
                    labelStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                    ),
                    keyboardType: TextInputType.multiline,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ]),
              ),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: textFormField(
                    controller: _studentIdController,
                    hintText: "Username",
                    borderWidth: 2,
                    borderRadius: 10,
                    validateMsg: "Field required",
                    labelStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                    ),
                    keyboardType: TextInputType.multiline,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ]),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: PasswordField(
                  controller: _passwordController,
                  hintText: "Password",
                  borderWidth: 2,
                  borderRadius: 10,
                  removeBorder: true,
                  validateMsg: "Field required",
                ),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: PasswordField(
                  controller: _confirmPasswordController,
                  hintText: "Confirm Password",
                  borderWidth: 2,
                  borderRadius: 10,
                  removeBorder: true,
                  validateMsg: "Field required",
                ),
              ),
              SizedBox(height: 20),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () async {
                  Map<String, String> admindetials = {
                    'name': _nameController.text,
                    'mail':
                        "${_studentIdController.text.trim()}@securityatu.com",
                  };
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  if (_passwordController.text !=
                      _confirmPasswordController.text) {
                    _showPasswordMismatchSnackbar();
                    return;
                  }
// Check student ID format
                  // if (!isStudentIdValid(_studentIdController.text.trim())) {
                  //   _showStudentIdFormatSnackbar();
                  //   return;
                  // }
                  setState(() {
                    _isLoading = true;
                  });

                  String result = await _fireAuth.signUp(
                    email:
                        "${_studentIdController.text.trim()}@securityatu.com",
                    studentId: _studentIdController.text,
                    name: _nameController.text,
                    password: _passwordController.text,
                  );
                  ref.push().set(admindetials).then((_) => Get.snackbar(
                      "Registration Success",
                      "Your User mail is ${_studentIdController.text}@securityatu.com"));
                  setState(() {
                    _isLoading = false;
                  });
                  try {
                    if (result == "success") {
                      _showRegistrationSuccessfulSnackbar();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                    }
                  } catch (e) {
                    Get.snackbar("Registration Error", "Error Detected!! ${e}");
                  }
                },
                child: Container(
                  // ignore: sort_child_properties_last
                  child: Center(
                    child: Text(
                      "Register",
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 225, 229, 235),
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                  ),
                  width: 152,
                  height: 47,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DARKBLUE,
                  ),
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
                            text: "Already have an account?\t\t",
                            style: GoogleFonts.roboto(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign in',
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
                                        builder: (context) => const Login()));
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
                height: 30,
              ),
              // if (_isLoading)
              //   Center(
              //     child: SizedBox(
              //       height: 50,
              //       width: 50,
              //       child: CircularProgressIndicator(
              //         color: GREEN,
              //         strokeWidth: 4.0,
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
