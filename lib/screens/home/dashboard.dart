// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_unnecessary_containers

import 'package:atusecurityapp/screens/annoucement/messageview.dart';
import 'package:atusecurityapp/screens/profile.dart';
import 'package:atusecurityapp/screens/reportscreen/reportpage.dart';
import 'package:atusecurityapp/screens/userscreen/usermain.dart';
import 'package:atusecurityapp/widget/navdrawer.dart';
import 'package:atusecurityapp/widgets/dashboardcard.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../module/dashboardmodule.dart';
import '../annoucement/announcements.dart';
import '../homepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:atusecurityapp/constants/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _DashboardState extends State<Dashboard> {
  List<DashboardModule> card = [
    DashboardModule("Users", Icons.verified_user_sharp, 5, ManageUsers()),
    DashboardModule("Reports", Icons.report, 5, ReportPage()),
    DashboardModule("Post Sites", Icons.location_on, 5, Annoucements()),
    DashboardModule("Messages", Icons.message, 5, MessageView()),
    DashboardModule("Profile", Icons.person, 5, ProfilePage()),
    DashboardModule("Announ\ncement", Icons.announcement, 5, Annoucements()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(),
      appBar: PreferredSize(
          child: AppBar(
            actions: [
              Text(
                "Hello,",
                style: GoogleFonts.montserrat(fontSize: 23),
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                "User",
                style: GoogleFonts.montserrat(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: AppColors.btnBlue),
              ),
              SizedBox(
                width: 110,
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
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                child: Icon(Icons.menu_outlined)),
            backgroundColor: Colors.white,
          ),
          preferredSize: const Size.fromHeight(60)),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  mainAxisSpacing: 10.0, // Spacing between rows
                  crossAxisSpacing: 10.0, // Spacing between columns
                ),
                itemCount: card.length, // Total number of items in the grid
                itemBuilder: (BuildContext context, int index) {
                  return GridTile(
                      child: DashboarddCards(
                    navigatePage: card[index].navigate,
                    cardIcon: card[index].icon,
                    counter: card[index].count,
                    title: card[index].title,
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
