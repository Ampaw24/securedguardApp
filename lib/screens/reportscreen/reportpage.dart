// ignore_for_file: sort_child_properties_last, prefer_const_constructors, list_remove_unrelated_type, no_leading_underscores_for_local_identifiers

import 'package:atusecurityapp/screens/reportscreen/viewreport.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/colors.dart';
import '../../constants/textstyle.dart';
import '../../modules/reportsmodule.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _reportCollection = FirebaseDatabase.instance.ref('Victim Report');

  deleteMessage(key) {
    _reportCollection.child(key).remove();
  }

  DatabaseReference? dbRef;
  int? _reportCount;
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Victim Report');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            actions: [
              Text(
                "Manage Reports",
                style: GoogleFonts.montserrat(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue),
              ),
              const SizedBox(
                width: 30,
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
                onTap: () => Get.back(), child: Icon(Icons.arrow_back)),
            backgroundColor: Colors.white,
          ),
          preferredSize: const Size.fromHeight(60)),
      body: Stack(
        children: [
          Positioned(
            left: 15,
            child: Text(
              "Available Reports",
              style: GoogleFonts.roboto(textStyle: headerboldblue2),
            ),
          ),
          StreamBuilder(
              stream: _reportCollection.onValue,
              builder: (context, snapShot) {
                if (snapShot.hasData &&
                    !snapShot.hasError &&
                    snapShot.data?.snapshot.value != null) {
                  Map _reportCollections = snapShot.data?.snapshot.value as Map;
                  List _reportItems = [];

                  _reportCollections.forEach((index, data) =>
                      _reportItems.add({"key": index, ...data}));
                  _reportCount = _reportItems.length;
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 35),
                    child: ListView.builder(
                        itemCount: _reportItems.length,
                        itemBuilder: (context, index) => Slidable(
                              child: Card(
                                elevation: 4,
                                color: Colors.white,
                                child: ListTile(
                                  trailing: GestureDetector(
                                    child: Icon(
                                      Icons.remove_red_eye_rounded,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  onTap: () => Get.to(
                                      transition: Transition.fadeIn,
                                      ViewReport(
                                          username: _reportItems[index]
                                              ['username'],
                                          crimelocation: _reportItems[index]
                                              ['location'],
                                          medicalassistance: _reportItems[index]
                                              ['date-of-crime'],
                                          discription: _reportItems[index]
                                              ['evidence'])),
                                  leading: Material(
                                    borderRadius: BorderRadius.circular(15),
                                    elevation: 2,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      child: Icon(
                                        size: 25,
                                        weight: 20,
                                        Icons.read_more,
                                        color: AppColors.cardBlue,
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                    ),
                                  ),
                                  title: Text(
                                    _reportItems[index]['username'],
                                    style: GoogleFonts.poppins(
                                        textStyle: headerboldblue2),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 14,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(_reportItems[index]['location'])
                                    ],
                                  ),
                                ),
                              ),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),

                          
                                children: [
                                  SlidableAction(
                                    onPressed: (BuildContext context) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                             
                                          return AlertDialog(
                                            title: Text('Confirm Delete'),
                                            content: Text(
                                                'Are you sure you want to delete this item?'),
                                            actions: <Widget>[
                                              // Button to cancel the deletion
                                              TextButton(
                                                child: Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                },
                                              ),
                                              // Button to confirm and delete
                                              TextButton(
                                                child: Text('Delete'),
                                                onPressed: () {
                                                  // Remove the item from the list

                                                  // Update the UI by rebuilding the widget
                                                  setState(() async {
                                                    await deleteMessage(
                                                        _reportItems[index]
                                                            ['key']);
                                                  });

                                                  // Close the dialog
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    backgroundColor: Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: FontAwesomeIcons.trashCan,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                            )),
                  );
                }
                return Container();
              })
        ],
      ),
    );
  }
}
                                  // onTap: () {
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) => ViewReport(
                                  //                 discription: reports[index]
                                  //                     .crime_discription,
                                  //                 crimelocation:
                                  //                     reports[index].location,
                                  //                 medicalassistance:
                                  //                     reports[index]
                                  //                         .medicalAssistance,
                                  //                 username:
                                  //                     reports[index].user_name,
                                  //               )));
                                  // },