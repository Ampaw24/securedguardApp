// ignore_for_file: prefer_const_constructors

import 'package:atusecurityapp/userGuard/model/notifyModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';



class Notifications extends StatefulWidget {
  const Notifications({Key? key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final databaseReference = FirebaseDatabase.instance.reference();
  List<Notify> notify = [];

  void fetchNews() {
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("Announcements");
    reference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> notifyMap = event.snapshot.value as Map;
        List<Notify> updatedNewsList = [];

        notifyMap.forEach((key, value) {
          Notify noti = Notify.fromMap(key, value as Map<dynamic, dynamic>);
          updatedNewsList.add(noti);
        });

        setState(() {
          notify = updatedNewsList;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Notifications'),
      ),
      body: ListView(
        children: notify.map((notification) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ExpansionTile(
              leading: Icon(Icons.notifications),
              title: Text(notification.title),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    notification.description,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
