// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_build_context_synchronously, depend_on_referenced_packages

import 'package:atusecurityapp/constants/colors.dart';
import 'package:atusecurityapp/screens/Login-SignUp/login.dart';
import 'package:atusecurityapp/widget/curledContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/firebase/firebaseauth.dart';
import '../../constants/textstyle.dart';
import '../../widget/custombutton.dart';
import '../../widget/formfieldbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

TextEditingController _username = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _mail = TextEditingController();

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
  bool containsDigit = false;
  bool passwordCheck = false;

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

  bool _isLoading = false;
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
                _isLoading
                    ? Stack(
                        children: [
                          Positioned(
                              child: CircularProgressIndicator(
                            backgroundColor:
                                GreenishgDarkTheme['themeColorDark'],
                          )),
                        ],
                      )
                    : Container(),
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
                        Text(
                          containsDigit
                              ? 'Full Name Should not  contains a digits or numbers'
                              : '',
                          style:
                              TextStyle(color: Colors.redAccent, fontSize: 10),
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
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            passwordCheck
                                ? 'Password length should be more than 7 characters!!'
                                : '',
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 10),
                          ),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: CustomButton1(
                            onpressed: () async {
                              if (RegExp(r'\d').hasMatch(_username.text)) {
                                setState(() {
                                  containsDigit = true;
                                });
                              } else if (_passwordController.text.length <= 7) {
                                setState(() {
                                  passwordCheck = true;
                                });
                              } else {
                                setState(() {
                                  containsDigit = false;
                                });
                                Map<String, String> admindetails = {
                                  'name': _username.text,
                                  'mail': "${_username.text.trim()}@scmatu.com",
                                };

                                setState(() {
                                  _isLoading = true;
                                });

                                String result = await _fireAuth.signUp(
                                  email: "${_username.text.trim()}@scmatu.com",
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

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                                Get.showSnackbar(GetSnackBar(
                                  title: "SignUp Success",
                                  message:
                                      "You are now an admin!! Enter Login Credentials to continue \n to dashboard",
                                  duration: Duration(seconds: 4),
                                  icon: Icon(Icons.done_all,
                                      color: Color(0xff13262E)),
                                ));
                                _username.text = " ";
                                _passwordController.text = "";
                                Get.to(LoginPage());

                                print("$result");
                              }
                            },
                            buttonText: "Register",
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
