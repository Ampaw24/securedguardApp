// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:atusecurityapp/screens/annoucement/announcements.dart';
import 'package:atusecurityapp/screens/annoucement/messageview.dart';
import 'package:atusecurityapp/screens/profile.dart';
import 'package:atusecurityapp/screens/reportscreen/reportpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:atusecurityapp/widget/draweritem.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
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
                          height: 20,
                        ),
                        Text('SECURED GUARD APP',
                            style: GoogleFonts.montserrat(
                                fontSize: 15, fontWeight: FontWeight.w900))
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
                          height: 30,
                        ),
                        DrawerItem(
                          name: 'Edit Profile',
                          icon: Icons.edit,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage()));
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DrawerItem(
                          name: 'Reports',
                          icon: Icons.report,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReportPage()));
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DrawerItem(
                            name: 'Annoucements',
                            icon: Icons.newspaper,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Annoucements()));
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        DrawerItem(
                            name: 'Alert',
                            icon: Icons.notifications_active,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MessageView()));
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
                          onPressed: () {},
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
