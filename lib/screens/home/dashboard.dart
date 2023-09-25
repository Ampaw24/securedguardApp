// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_unnecessary_containers, depend_on_referenced_packages, unused_import, duplicate_import, unused_field, avoid_print, use_build_context_synchronously

import 'package:atusecurityapp/constants/postsites/postsites.dart';
import 'package:atusecurityapp/screens/Login-SignUp/login.dart';
import 'package:atusecurityapp/screens/annoucement/messageview.dart';
import 'package:atusecurityapp/screens/profile.dart';
import 'package:atusecurityapp/screens/reportscreen/reportpage.dart';
import 'package:atusecurityapp/screens/userscreen/usermain.dart';
import 'package:atusecurityapp/widget/navdrawer.dart';
import 'package:atusecurityapp/widgets/dashboardcard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../module/dashboardmodule.dart';
import '../annoucement/announcements.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:atusecurityapp/constants/colors.dart';

class Dashboard extends StatefulWidget {
  String username;
  Dashboard({required this.username});

  @override
  State<Dashboard> createState() => _DashboardState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _DashboardState extends State<Dashboard> {
  String? _userName;
  String? _imageUrl;
  String? _maill;
  bool isLoading = false;
  bool isImageready = false;
  int _pageindex = 1;
  List<DashboardModule> card = [
    DashboardModule(
        "Manage \nGuards", Icons.verified_user_sharp, 5, ManageUsers()),
    DashboardModule("Reports", Icons.report, 5, ReportPage()),
    DashboardModule("Post Sites", Icons.location_on, 5, BTMnav(pageIndex: 1)),
    DashboardModule("Messages", Icons.message, 5, MessageView()),
    DashboardModule("Profile", Icons.person, 5, ProfilePage()),//replaced with tips pages
    DashboardModule("Announ\ncement", Icons.announcement, 5, Announcements()),
  ];

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure You want to Logout this section?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Log Out'),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await FirebaseAuth.instance.signOut();

                setState(() {
                  isLoading = false;
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    loadAmindetails(widget.username);
    super.initState();
  }

  void loadAmindetails(var name) {
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child("userprofile");
    reference.onValue.listen((DatabaseEvent snapshot) {
      print("${snapshot.snapshot.value}");

      if (snapshot.snapshot.value != null) {
        Map<dynamic, dynamic>? usersData = snapshot.snapshot.value as Map?;
        usersData?.forEach((key, value) {
          if (value["username"] == name) {
            _userName = value["name"];
            _imageUrl = value["imageLink"];

            if (_imageUrl != null) {
              setState(() {
                isImageready = true;
              });
            }

            print(_imageUrl);
          }
        });
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(usermail: widget.username.toString()),
      appBar: PreferredSize(
          child: AppBar(
            centerTitle: true,
            title: Text(
              "Secured Guard App",
              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 18)),
            ),
            actions: [
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () => _showMyDialog(),
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      margin: const EdgeInsets.only(right: 15),
                      width: 110,
                      height: 35,
                      decoration: BoxDecoration(
                          color: AppColors.btnBlue.withOpacity(.7),
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        margin: const EdgeInsets.only(right: 60),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/profile.png"),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 45,
                      right: 15,
                      child: Text(
                        "Sign Out",
                        style: GoogleFonts.lato(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
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
