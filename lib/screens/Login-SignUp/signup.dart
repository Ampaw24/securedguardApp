// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_build_context_synchronously

import 'package:atusecurityapp/constants/colors.dart';
import 'package:atusecurityapp/screens/Login-SignUp/login.dart';
import 'package:atusecurityapp/widget/curledContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/firebase/firebaseauth.dart';
import '../../constants/textstyle.dart';
import '../../widget/custombutton.dart';
import '../../widget/formfieldbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

TextEditingController _username = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _mail = TextEditingController();
String? _gender;

class _SignUpPageState extends State<SignUpPage> {
  FireAuth _fireAuth = FireAuth();
  void verifyMe(String username, String password, String mail) {
    if (username.isEmpty) {
      print("Helo");
    }
  }

  void NextPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  List<String> _gender = [
    'Male',
    'Female',
  ];
  String? _selectedGender;
  List<DropdownMenuItem> getDropdownData() {
    List<DropdownMenuItem<String>> dropdownItem = [];
    for (var index = 0; index < _gender.length; index++) {
      String options = _gender[index];
      var dropItem = DropdownMenuItem(
          value: options,
          child: Text(
            options.toUpperCase(),
          ));
      dropdownItem.add(dropItem);
    }
    return dropdownItem;
  }

  bool? _isLoading;
  late DatabaseReference ref;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ref = FirebaseDatabase.instance.ref().child('Admindetails');
  }

  void showToast() {}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: GreenishgDarkTheme['themeColorDark'],
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 27),
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
                SizedBox(
                  height: 10,
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
                    color: GreenishgDarkTheme['cardWhite'],
                    boxwidth: 320,
                    boxheight: MediaQuery.of(context).size.height * 1.43,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.poppins(
                              textStyle: kLoginTextHead,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FormFieldBox(
                          controller: _username,
                          prefixi: Icons.person,
                          hinttext: "Enter UserName",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FormFieldBox(
                          controller: _passwordController,
                          prefixi: Icons.lock,
                          suffixi: Icons.remove_red_eye,
                          hinttext: "Enter Password",
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          child: DropdownButtonFormField(
                              onSaved: (value) {
                                _gender = value;
                              },
                              isExpanded: true,
                              decoration: InputDecoration(
                                  // filled: true,

                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.white))),
                              value: _selectedGender,
                              hint: Text("Select Gender"),
                              items: getDropdownData(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              }),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: CustomButton1(
                            onpressed: () async {
                              Map<String, String> admindetails = {
                                'name': _username.text,
                                'mail': "${_username.text.trim()}@scmatu.com",
                              };

                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              setState(() {
                                _isLoading = true;
                              });

                              String result = await _fireAuth.signUp(
                                email: "${_username.text.trim()}@crsatu.com",
                                studentId: _username.text,
                                name: _username.text,
                                password: _passwordController.text,
                              );
                              ref
                                  .push()
                                  .set(admindetails)
                                  .then((_) => print('Admin Added'))
                                  .catchError((e) => print(e));

                              setState(() {
                                _isLoading = false;
                              });
                              if (result == "success") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                                Flushbar(
                                  title: "SignUp Success",
                                  message:
                                      "You are now an admin!! Enter Login Credentials to continue \n to dashboard",
                                  duration: Duration(seconds: 4),
                                  icon: Icon(Icons.done_outline_rounded,
                                      color: Colors.white),
                                  backgroundColor:
                                      Color.fromARGB(255, 52, 59, 61)
                                          .withOpacity(0.6),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  animationDuration:
                                      Duration(milliseconds: 500),
                                  borderRadius: BorderRadius.circular(10),
                                  margin: EdgeInsets.all(8.0),
                                  onTap: (flushbar) {
                                    flushbar.dismiss();
                                  },
                                ).show(context);
                              } else {
                                print("$result");
                              }
                            },
                            buttonText: "Register",
                          ),
                        ),
                      ],
                    )),
                     if (_isLoading!)
            Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
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
