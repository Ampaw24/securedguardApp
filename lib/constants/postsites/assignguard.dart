// ignore_for_file: prefer_const_constructors

import 'package:atusecurityapp/constants/colors.dart';
import 'package:atusecurityapp/constants/textstyle.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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
            margin: const EdgeInsets.only(top: 10, left: 15),
            child: Text(
              " Manage Locations ",
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 15,
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
                          return Card(
                            elevation: 3,
                            child: ListTile(
                              title: Text(_newsItems[index]['loacation_Id']),
                              subtitle:
                                  Text(_newsItems[index]['location_Name']),
                              leading: Icon(Icons.location_on_rounded),
                              trailing: GestureDetector(
                                onTap: () {
                                  Get.defaultDialog(
                                    backgroundColor: Colors.white,
                                    radius: 10,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    title: 'Delete Confirmation',
                                    titleStyle: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.btnBlue,
                                        fontWeight: FontWeight.w400),
                                    content: Text(
                                        'Are you sure you want to delete this item?'),
                                    textConfirm:
                                        'Confirm', // Change the button text to "Get X"
                                    textCancel: 'Cancel',
                                    onCancel: () => Get.back(),
                                    onConfirm: () async {
                                      await deleteMessage(
                                          _newsItems[index]['key']);
                                      Get.back();
                                      Get.showSnackbar(GetSnackBar(
                                        duration: Duration(seconds: 3),
                                        title: "Location Deleted",
                                        message:
                                            " Location ${_newsItems[index]['loacation_Id']}",
                                      ));
                                    },
                                  );
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
                            ),
                          );
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  })),
        ],
      ),
    );
  }
}
