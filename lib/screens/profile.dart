// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_final_fields, avoid_unnecessary_containers

import 'dart:typed_data';
import 'package:atusecurityapp/constants/colors.dart';
import 'package:atusecurityapp/constants/firebase/firebaseauth.dart';
import 'package:atusecurityapp/module/storedata.dart';
import 'package:atusecurityapp/screens/Login-SignUp/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/textstyle.dart';
import '../constants/utils.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey _formkey = GlobalKey();
  Uint8List? _image;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _conpasswordController = TextEditingController();
  TextEditingController _staffIdController = TextEditingController();
  void _selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void saveProfile() async {
    String username = _staffIdController.text;
    String resp = await StoreData().saveUrldb(name: username, file: _image!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            centerTitle: true,
            title: Text(
              "Edit Profile",
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.btnBlue),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                    child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/Accra Technical University.png'),
                          fit: BoxFit.cover)),
                )),
              ],
            ),
            Text(
              "ATU SECURED GUARD APP",
              style:
                  GoogleFonts.roboto(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            Text(
              " ${FirebaseAuth.instance.currentUser!.email}  ",
              style: GoogleFonts.roboto(),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        margin: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'New Password',
                            ),
                            // validator: _validatePassword(),
                          ),
                        ),
                        height: 50,
                        width: 300,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        margin: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: TextFormField(
                            controller: _conpasswordController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                            ),
                            // validator: _validatePassword(),
                          ),
                        ),
                        height: 50,
                        width: 300,
                      ),
                      GestureDetector(
                        onTap: () async {
                          try {
                            if (_passwordController.text ==
                                _conpasswordController.text) {
                              await FirebaseAuth.instance.currentUser!
                                  .updatePassword(_conpasswordController.text)
                                  .then((_) => Get.showSnackbar(GetSnackBar(
                                        title: "Update Success",
                                        message: "User Credentials Updated",
                                        snackPosition: SnackPosition.BOTTOM,
                                      )));
                              _conpasswordController.text = " ";
                              _passwordController.text = " ";
                            } else {
                              Get.showSnackbar(GetSnackBar(
                                title: "Error Updating",
                                message:
                                    "Error Updating User Credentials for User. \n Check password fields",
                              ));
                              _conpasswordController.text = " ";
                              _passwordController.text = " ";
                            }
                          } catch (e) {
                            print("Error Changing Display Name ${e}");
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          margin: const EdgeInsets.only(top: 30),
                          child: Center(
                            child: Text(
                              "Update",
                              style: GoogleFonts.montserrat(
                                  textStyle: subheaderBoldbtnwhite),
                            ),
                          ),
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                              color: AppColors.btnBlue,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      OutlinedButton.icon(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Get.to(LoginPage());
                          },
                          icon: Icon(Icons.logout),
                          label: Text("Logout"))
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
