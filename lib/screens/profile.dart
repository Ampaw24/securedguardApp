// ignore_for_file: prefer_const_constructors, sort_child_properties_last


import 'dart:typed_data';

import 'package:atusecurityapp/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/textstyle.dart';
import '../constants/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey _formkey = GlobalKey();
  Uint8List? _image;
  void _selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
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
                  fontWeight: FontWeight.w600,
                  color: AppColors.btnBlue),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child:_image != null ? Container(
                    margin: const EdgeInsets.only(top: 30),
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        image: DecorationImage(
                            image: MemoryImage(_image!),
                            fit: BoxFit.cover)),
                  ) : Container(
                    margin: const EdgeInsets.only(top: 30),
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        image: DecorationImage(
                            image: AssetImage('assets/profile.png'),
                            fit: BoxFit.cover)),
                  ),
                ),
                Positioned(
                    top: 110,
                    left: 210,
                    child: GestureDetector(
                      onTap: _selectImage,
                      child: Container(
                        child: Center(
                          child: Icon(
                            Icons.add_a_photo,
                            weight: 10,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.btnBlue,
                        ),
                      ),
                    )),
              ],
            ),
            Text(
              "David Soweto",
              style: GoogleFonts.roboto(textStyle: headerboldblue1),
            ),
            Text(
              "Lecturer",
              style: GoogleFonts.roboto(),
            ),
            SizedBox(
              height: 20,
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
                        child: Center(
                          child: TextFormField(
                            // controller: _staffIdController,
                            decoration: InputDecoration(
                              labelText: 'Staff Mail',
                            ),
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
                            // controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
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
                            // controller: _passwordController,
                            obscureText: true,
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
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          margin: const EdgeInsets.only(top: 20),
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
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
