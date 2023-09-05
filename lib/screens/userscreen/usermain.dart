// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:atusecurityapp/modules/usermodule.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/colors.dart';
import '../../constants/textstyle.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key});

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  List<UserModule> user = [
    UserModule(
        email: "jamaien@sga.mail.com",
        profile_url: "assets/logomain.png",
        userId: "sga01",
        userName: "jamiel01",
        gender: "Male",
        age: 10),
    UserModule(
        email: "jamaien@sga.mail.com",
        profile_url: "assets/logomain.png",
        userId: "sga01",
        userName: "jamiel01",
        gender: "Male",
        age: 50),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: AppBar(
            actions: [
              Text(
                "Manage Users",
                style: GoogleFonts.montserrat(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: AppColors.btnBlue),
              ),
              const SizedBox(
                width: 50,
              ),
              Container(
                margin: const EdgeInsets.only(right: 20),
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/profile.jpg"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(20)),
              )
            ],
            leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back)),
            backgroundColor: Colors.white,
          ),
          preferredSize: const Size.fromHeight(60)),
      body: SingleChildScrollView(
        child: Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "   Users ${user.length.toString()}",
              style: GoogleFonts.roboto(textStyle: headerboldblue1),
            ),
            ListView.builder(
                itemCount: user.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                      trailing: GestureDetector(
                        child: GestureDetector(
                          onTap: () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Center(
                                        child: Text(
                                      'Details',
                                      style: GoogleFonts.poppins(),
                                    )),
                                    content: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          // Rounded user image
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                45.0), // Make it a circle
                                            child: Image.asset(
                                              user[index].profile_url,
                                              width: 90.0,
                                              height: 90.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(height: 12.0),
                                          // User details
                                          Text(
                                            user[index].userName,
                                            style: TextStyle(
                                              color: AppColors.btnBlue,
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                              "User Id: ${user[index].userId}",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                          child: Icon(
                            FontAwesomeIcons.circleInfo,
                            size: 22,
                            color: AppColors.btnBlue,
                            weight: 3,
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  user[index].profile_url,
                                ),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      title: Text(
                        user[index].userName,
                        style: GoogleFonts.poppins(textStyle: headerboldblue2),
                      ),
                      subtitle: Text(
                        maxLines: 2,
                        "",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                            textStyle: TextStyle()),
                      ),
                    )),
          ]),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppColors.btnBlue,
      //   onPressed: () {},
      //   child: Icon(
      //     FontAwesomeIcons.add,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}
