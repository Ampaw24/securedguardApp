// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:atusecurityapp/userGuard/modules/notification/notification_page.dart';
import 'package:atusecurityapp/userGuard/specs/colors.dart';
import 'package:flutter/material.dart';
import '../modules/allocations/allocations.dart';
import '../screens/Homepage/homepage.dart';
import '../modules/Report/report.dart';

class BTMnav extends StatefulWidget {
  const BTMnav({Key? key, required this.pageIndex}) : super(key: key);
  final int pageIndex;

  @override
  State<BTMnav> createState() => _BTMnavState();
}

class _BTMnavState extends State<BTMnav> {
  final pages = [
    Homepage(),
    Report(),
    Allocations(),
    Notifications(),
  ];

  late int _pageIndex;

  @override
  void initState() {
    super.initState();
    _pageIndex = widget.pageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_pageIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: WHITE,
            labelTextStyle: MaterialStatePropertyAll(TextStyle(
                fontSize: 10,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                color: WHITE)),
            indicatorShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
        child: NavigationBar(
            height: 63,
            backgroundColor: SEABLUE,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            animationDuration: Duration(seconds: 1),
            selectedIndex: _pageIndex,
            onDestinationSelected: (pageIndex) =>
                setState(() => _pageIndex = pageIndex),
            destinations: [
              NavigationDestination(
                icon: Icon(
                  Icons.home,
                  color: DARKBLUE,
                ),
                selectedIcon: Icon(
                  Icons.home,
                  color: DARKBLUE,
                ),
                label: 'HOME',
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.report_gmailerrorred,
                  color: DARKBLUE,
                ),
                selectedIcon: Icon(
                  Icons.report_gmailerrorred,
                  color: Colors.black,
                ),
                label: 'Report',
              ),
              NavigationDestination(
                  icon: Icon(
                    Icons.chat_outlined,
                    color: DARKBLUE,
                  ),
                  selectedIcon: Icon(
                    Icons.assignment,
                    color: DARKBLUE,
                  ),
                  label: 'Allocations'),
              NavigationDestination(
                icon: Icon(
                  Icons.notification_add,
                  color: DARKBLUE,
                ),
                selectedIcon: Icon(
                  Icons.notification_add,
                  color: Colors.black,
                ),
                label: 'Notification',
              ),
            ]),
      ),
    );
  }
}
