// ignore_for_file: prefer_const_constructors

import 'package:atusecurityapp/constants/colors.dart';
import 'package:atusecurityapp/constants/textstyle.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class AssignGuard extends StatefulWidget {
  const AssignGuard({super.key});

  @override
  State<AssignGuard> createState() => _AssignGuardState();
}

class _AssignGuardState extends State<AssignGuard> {
  final _newsCollection = FirebaseDatabase.instance.ref('PostSitesLocations');

  deleteMessage(key) {
    _newsCollection.child(key).remove();
  }

  DatabaseReference? dbRef;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('PostSitesLocations');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 7, left: 15),
            child: Text(
              "\n Manage Locations ",
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
              child: StreamBuilder(
                  stream: _newsCollection.onValue,
                  builder: (context, snapShot) {
                    if (snapShot.hasData &&
                        !snapShot.hasError &&
                        snapShot.data?.snapshot.value != null) {
                      Map _newsCollections =
                          snapShot.data?.snapshot.value as Map;
                      List _newsItems = [];
                      _newsCollections.forEach((index, data) =>
                          _newsItems.add({"key": index, ...data}));

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: _newsItems.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            trailing: GestureDetector(
                              onTap: () async {
                                await deleteMessage(_newsItems[index]['key']);

                                Fluttertoast.showToast(
                                    msg: "Post Site Deleted!!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black45,
                                    textColor: Colors.white,
                                    fontSize: 15.0);
                              },
                              child: Icon(
                                Icons.cancel,
                                size: 18,
                                color: AppColors.cardRed,
                                weight: 3,
                              ),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            title: Text(_newsItems[index]['title'],
                                style: GoogleFonts.poppins(
                                    textStyle: headerboldblue2)),
                            subtitle: Text(_newsItems[index]['description'],
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200,
                                    textStyle: TextStyle())),
                          );
                        },
                      );
                    }
                    return Container();
                  })),
        ],
      ),
    );
  }
}
