// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, sort_child_properties_last, unnecessary_string_interpolations

import 'package:atusecurityapp/userGuard/model/adviceModel.dart';
import 'package:atusecurityapp/userGuard/specs/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Auth/Login/login.dart';
import '../../config/deleteCache.dart';
import '../../config/firebase/firebaseAuth.dart';
import '../../config/sharePreference.dart';
import '../../specs/arrays.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

FireAuth _fireAuth = FireAuth();

class _HomepageState extends State<Homepage> {
  int index = 0;
  final databaseReference = FirebaseDatabase.instance.reference();
  List<AdviceModel> tipsList = [];

  void fetchTips() {
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("GuardTip");
    reference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> tipsMap = event.snapshot.value as Map;
        List<AdviceModel> updatedTipsList = [];

        tipsMap.forEach((key, value) {
          AdviceModel tips =
              AdviceModel.fromMap(key, value as Map<dynamic, dynamic>);
          updatedTipsList.add(tips);
        });

        setState(() {
          tipsList = updatedTipsList;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Legal Advice",
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  height: 20,
                  child: ListTile(
                    leading:
                        Icon(Icons.more_vert_outlined, color: Colors.white),
                    title: Text('Logout'),
                    onTap: () {
                      _showLogoutBottomSheet(context);
                    },
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            for (var data in tipsList)
              Container(
                  margin: EdgeInsets.all(10),
                  height: 150,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: DEEPGREY),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            child: Text(
                              "  ${data.title}",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: WHITE,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5),
                        child: Text(
                          "${data.description}",
                          style: TextStyle(
                            fontSize: 13,
                            inherit: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ))
          ],
        ),
      ),
    );
  }
}

void _showLogoutBottomSheet(BuildContext context) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) {
      return CupertinoActionSheet(
        title: Text('Are you sure you want to Logout?'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              await _fireAuth.signOut();
              await saveBoolShare(key: "auth", data: false);
              await deleteCache();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: Text('Logout'),
            isDestructiveAction: true,
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      );
    },
  );
}
