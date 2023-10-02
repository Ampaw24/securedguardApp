// ignore_for_file: sort_child_properties_last, prefer_const_constructors, unused_field, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'dart:io';
import 'package:atusecurityapp/constants/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class GuardTip extends StatefulWidget {
  const GuardTip({super.key});

  @override
  State<GuardTip> createState() => _GuardTipState();
}

class _GuardTipState extends State<GuardTip> {
  TextEditingController newsTitleController = TextEditingController();
  TextEditingController newsDescriptionController = TextEditingController();
  TextEditingController file = TextEditingController();
  TextEditingController idcontroller = TextEditingController();

  final storageRef = FirebaseStorage.instance.ref();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  final _newsCollection = FirebaseDatabase.instance.ref('GuardTip');

  deleteMessage(key) {
    _newsCollection.child(key).remove();
  }

  DatabaseReference? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('GuardTip');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              actions: [
                Center(
                  child: Text(
                    "Create Guard Tips",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.btnBlue),
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
              ],
              leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back)),
              backgroundColor: Colors.white,
            ),
            preferredSize: const Size.fromHeight(60)),
        body: SafeArea(
          child: Scrollbar(
            child: StreamBuilder(
                stream: _newsCollection.onValue,
                builder: (context, snapShot) {
                  if (snapShot.hasData &&
                      !snapShot.hasError &&
                      snapShot.data?.snapshot.value != null) {
                    Map _newsCollections = snapShot.data?.snapshot.value as Map;
                    List _newsItems = [];
                    _newsCollections.forEach((index, data) =>
                        _newsItems.add({"key": index, ...data}));
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: _newsItems.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 10,
                          color: Colors.white,
                          child: ListTile(
                            leading: ClipRRect(
                                child: Container(
                                  color: AppColors.cardYellow,
                                  width: 50,
                                  height: 50,
                                  child: Center(
                                      child: Icon(FontAwesomeIcons.lightbulb)),
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            trailing: GestureDetector(
                              onTap: () async {
                                await deleteMessage(_newsItems[index]['key']);

                                Fluttertoast.showToast(
                                    msg:
                                        "Tip Deleted!! \n Add Tips for Guards..",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black45,
                                    textColor: Colors.white,
                                    fontSize: 15.0);
                              },
                              child: Icon(
                                FontAwesomeIcons.trashCan,
                                size: 18,
                                color: AppColors.btnBlue,
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
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            isExtended: true,
            elevation: 6,
            child: Icon(Icons.add, color: Colors.white, size: 25, fill: 1.0),
            backgroundColor: Colors.blue,
            onPressed: () {
              Get.bottomSheet(
                  elevation: 5.0,
                  enableDrag: true,
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Create Daily Tips",
                          style: GoogleFonts.poppins(
                            textStyle: headerboldblue2,
                          ),
                        ),
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Title',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextFormField(
                                  controller: newsTitleController,
                                  decoration: InputDecoration(
                                    hintText: 'Tip title',
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  'Tip Content',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextFormField(
                                  controller: newsDescriptionController,
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                    hintText: 'Add description',
                                  ),
                                ),
                                SizedBox(height: 14),
                                GestureDetector(
                                  onTap: () {
                                    Map<String, String> news = {
                                      'announcementId': idcontroller.text,
                                      'title': newsTitleController.text,
                                      'description':
                                          newsDescriptionController.text,
                                    };

                                    dbRef?.push().set(news).then((_) {
                                      Get.showSnackbar(GetSnackBar(
                                        title: "Guard Tip Posted",
                                        message:
                                            "Guard Tip ${newsTitleController.text} posted",
                                        duration: Duration(seconds: 4),
                                        backgroundColor:
                                            Color.fromARGB(255, 43, 51, 54)
                                                .withOpacity(0.6),
                                        margin: EdgeInsets.all(8.0),
                                      ));

                                      idcontroller.text = "";
                                      newsTitleController.text = "";
                                      newsDescriptionController.text = "";
                                    }).catchError((_) {
                                      Get.showSnackbar(GetSnackBar(
                                        title: "AGuard Tip Post Error",
                                        message:
                                            "Guard Tip ${newsTitleController.text} posted Error",
                                        duration: Duration(seconds: 4),
                                        backgroundColor:
                                            Color.fromARGB(255, 43, 51, 54)
                                                .withOpacity(0.6),
                                        margin: EdgeInsets.all(8.0),
                                      ));
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    margin: const EdgeInsets.only(top: 20),
                                    child: Center(
                                      child: Text(
                                        "Post Guard Tip",
                                        style: GoogleFonts.montserrat(
                                            textStyle: subheaderBoldbtnwhite),
                                      ),
                                    ),
                                    height: 50,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        color: AppColors.cardBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
            }));
  }
}
