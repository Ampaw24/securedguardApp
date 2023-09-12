// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:io';
import 'package:atusecurityapp/constants/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostSites extends StatefulWidget {
  const PostSites({super.key});

  @override
  State<PostSites> createState() => _PostSitesState();
}

class _PostSitesState extends State<PostSites> {
  TextEditingController newsTitleController = TextEditingController();
  TextEditingController newsDescriptionController = TextEditingController();
  TextEditingController file = TextEditingController();
  final storageRef = FirebaseStorage.instance.ref();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedFileName = "Attach File";
  String? filename;
  PlatformFile? pickedFile;
  bool isLoading = false;
  File? fileToDisplay;
  //News data fetch
  Map? _newsVals;
  String? newsTitle;
  String? newsDescription;
  final _newsCollection = FirebaseDatabase.instance.ref('News');

  deleteMessage(key) {
    _newsCollection.child(key).remove();
  }

  DatabaseReference? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('News');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            actions: [
              Center(
                child: Text(
                  "Post Sites",
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
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
          child: Expanded(
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
                                    msg: "Announcement Deleted!!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
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
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 20),
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.btnBlue,
          onPressed: () {
            setState(() {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => Wrap(children: [
                        SingleChildScrollView(
                          child: SafeArea(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.80,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Create Annoucement",
                                      style: GoogleFonts.poppins(
                                        textStyle: headerboldblue2,
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'News Headline',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextFormField(
                                              controller: newsTitleController,
                                              decoration: InputDecoration(
                                                hintText: 'Enter title',
                                              ),
                                            ),
                                            SizedBox(height: 12),
                                            Text(
                                              'News Detail',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextFormField(
                                              controller:
                                                  newsDescriptionController,
                                              maxLines: 2,
                                              decoration: InputDecoration(
                                                hintText: 'Enter description',
                                              ),
                                            ),
                                            SizedBox(height: 14),
                                            GestureDetector(
                                              onTap: () {
                                                Map<String, String> news = {
                                                  'title':
                                                      newsTitleController.text,
                                                  'description':
                                                      newsDescriptionController
                                                          .text,
                                                };

                                                dbRef
                                                    ?.push()
                                                    .set(news)
                                                    .then((_) {
                                                  Flushbar(
                                                    title: "News Posted",
                                                    message:
                                                        "News ${newsTitleController.text} posted",
                                                    duration:
                                                        Duration(seconds: 4),
                                                    icon: Icon(
                                                        Icons
                                                            .done_outline_rounded,
                                                        color: Colors.white),
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                                255, 43, 51, 54)
                                                            .withOpacity(0.6),
                                                    flushbarPosition:
                                                        FlushbarPosition.TOP,
                                                    animationDuration: Duration(
                                                        milliseconds: 500),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    margin: EdgeInsets.all(8.0),
                                                    onTap: (flushbar) {
                                                      flushbar.dismiss();
                                                    },
                                                  ).show(context);

                                                  newsTitleController.text = "";
                                                  newsDescriptionController
                                                      .text = "";
                                                }).catchError((_) {
                                                  Flushbar(
                                                    title: "News Post Error",
                                                    message:
                                                        "News ${newsTitleController.text} Error",
                                                    duration:
                                                        Duration(seconds: 4),
                                                    icon: Icon(
                                                        Icons
                                                            .done_outline_rounded,
                                                        color: Colors.white),
                                                    backgroundColor:
                                                        Color.fromARGB(255, 237,
                                                                51, 51)
                                                            .withOpacity(0.6),
                                                    flushbarPosition:
                                                        FlushbarPosition.TOP,
                                                    animationDuration: Duration(
                                                        milliseconds: 300),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    margin: EdgeInsets.all(8.0),
                                                    onTap: (flushbar) {
                                                      flushbar.dismiss();
                                                    },
                                                  ).show(context);
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                                margin: const EdgeInsets.only(
                                                    top: 20),
                                                child: Center(
                                                  child: Text(
                                                    "Make Announcement",
                                                    style: GoogleFonts.montserrat(
                                                        textStyle:
                                                            subheaderBoldbtnwhite),
                                                  ),
                                                ),
                                                height: 50,
                                                width: 300,
                                                decoration: BoxDecoration(
                                                    color: AppColors.cardBlue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]));
            });
          },
          child: Icon(
            FontAwesomeIcons.add,
            color: Colors.white,
            weight: 3,
          )),
    );
  }
}
