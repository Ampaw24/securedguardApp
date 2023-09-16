// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:atusecurityapp/constants/postsites/postsites.dart';
import 'package:atusecurityapp/screens/annoucement/announcements.dart';
import 'package:atusecurityapp/screens/annoucement/messageview.dart';
import 'package:atusecurityapp/screens/profile.dart';
import 'package:atusecurityapp/screens/reportscreen/reportpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:atusecurityapp/widget/draweritem.dart';
import 'package:get/get.dart';
import '../screens/Login-SignUp/login.dart';

class NavDrawer extends StatefulWidget {
  final String usermail;

  const NavDrawer({super.key, required this.usermail});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 254,
      height: 673.2,
      child: Drawer(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          color: Color.fromARGB(47, 158, 158, 158),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 700,
                    height: 187,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: Color.fromARGB(25, 158, 158, 158)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          'assets/Accra Technical University.png',
                          width: 300,
                          height: 110,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("${widget.usermail.trim()}@staff.sm",
                            style: GoogleFonts.montserrat(
                                fontSize: 10, fontWeight: FontWeight.w300)),
                        Text('SECURED GUARD APP',
                            style: GoogleFonts.montserrat(
                                fontSize: 15, fontWeight: FontWeight.w400))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 700,
                    height: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: Color.fromARGB(25, 158, 158, 158)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        DrawerItem(
                          name: 'Edit Profile',
                          icon: Icons.edit,
                          onPressed: () {
                            Get.to(ProfilePage(),
                                transition: Transition.rightToLeft);
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DrawerItem(
                          name: 'Reports',
                          icon: Icons.report,
                          onPressed: () {
                            Get.to(ReportPage(),
                                transition: Transition.rightToLeft);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DrawerItem(
                            name: 'Annoucements',
                            icon: Icons.newspaper,
                            onPressed: () {
                              Get.to(Announcements(),
                                  transition: Transition.rightToLeft);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        DrawerItem(
                            name: 'Sites',
                            icon: Icons.location_on,
                            onPressed: () {
                              Get.to(BTMnav(pageIndex: 1),
                                  transition: Transition.rightToLeft);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 700,
                    height: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: Color.fromARGB(25, 158, 158, 158)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        DrawerItem(
                          name: 'Help',
                          icon: Icons.help,
                          onPressed: () {},
                        ),
                        DrawerItem(
                          name: 'Logout',
                          icon: Icons.login_rounded,
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();

                            Get.to(LoginPage(),
                                transition: Transition.downToUp);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);

    switch (index) {
      case 0:
        break;
    }
  }

  Widget headerWidget() {
    return Container(
      width: 300,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("assets/CSA.png"),
          ),
          SizedBox(
            width: 10,
          ),
          Text('GDPR',
              style: TextStyle(
                  fontSize: 14, color: Color.fromARGB(255, 226, 9, 9)))
        ],
      ),
    );
  }
}
