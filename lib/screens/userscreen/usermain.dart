// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:atusecurityapp/modules/usermodule.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/colors.dart';
import '../../constants/textstyle.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key});

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  List<UserModule> user = [
    UserModule(
        email: "jamaien@sga.mail.com",
        profile_url: "assets/logomain.png",
        userId: "sga01",
        userName: "jamiel01",
        gender: "Male",
        age: 10),
    UserModule(
        email: "jamaien@sga.mail.com",
        profile_url: "assets/logomain.png",
        userId: "sga01",
        userName: "jamiel01",
        gender: "Male",
        age: 50),
  ];
  final _userCollection = FirebaseDatabase.instance.ref('Users');
  int? _total_guards;

  deleteMessage(key) {
    _userCollection.child(key).remove();
  }

  DatabaseReference? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Users');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: AppBar(
            title: Text(
              "Manage Guards",
              style: GoogleFonts.montserrat(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue),
            ),
            centerTitle: true,
            actions: const [
              SizedBox(
                width: 50,
              ),
            ],
            leading: GestureDetector(
                onTap: () => Get.back(), child: Icon(Icons.arrow_back)),
            backgroundColor: Colors.white,
          ),
          preferredSize: const Size.fromHeight(60)),
      body: SingleChildScrollView(
        child: Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "     Guards  ${_total_guards.toString()}",
              style: GoogleFonts.roboto(textStyle: headerboldblue2),
            ),
            StreamBuilder(
                stream: _userCollection.onValue,
                builder: (context, snapShot) {
                  if (snapShot.hasData &&
                      !snapShot.hasError &&
                      snapShot.data?.snapshot.value != null) {
                    Map _userCollections = snapShot.data?.snapshot.value as Map;
                    List _userItems = [];
                    _userCollections.forEach((index, data) =>
                        _userItems.add({"key": index, ...data}));

                    _total_guards = _userItems.length;

                    print(_total_guards);
                    return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        itemCount: _userItems.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Card(
                              elevation: 5,
                              color: Colors.white,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                trailing: GestureDetector(
                                    onTap: () => print(_total_guards),
                                    child: Icon(Icons.info)),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    color: AppColors.cardBlue,
                                    child: Icon(
                                      Icons.supervised_user_circle_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                subtitle: Text(_userItems[index]['email']),
                                title: Text(
                                  _userItems[index]['name'],
                                  style: GoogleFonts.poppins(
                                      textStyle: headerboldblue2),
                                ),
                              ),
                            ));
                  }
                  return Container();
                }),
          ]),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppColors.btnBlue,
      //   onPressed: () {},
      //   child: Icon(
      //     FontAwesomeIcons.add,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}
// GestureDetector (
//                                     onTap: () => showDialog(
//                                         context: context,
//                                         builder: (context) => AlertDialog(
//                                               backgroundColor: Colors.white,
//                                               title: Center(
//                                                   child: Text(
//                                                 'Details',
//                                                 style: GoogleFonts.poppins(),
//                                               )),
//                                               content: Padding(
//                                                 padding: EdgeInsets.all(10.0),
//                                                 child: Column(
//                                                   textBaseline:
//                                                       TextBaseline.ideographic,
//                                                   mainAxisSize:
//                                                       MainAxisSize.min,
//                                                   children: <Widget>[
//                                                     // Rounded user image
//                                                     ClipRRect(
//                                                         borderRadius:
//                                                             BorderRadius.circular(
//                                                                 45.0), // Make it a circle
//                                                         child: Container(
//                                                           height: 50,
//                                                           width: 50,
//                                                           color: Colors
//                                                               .greenAccent,
//                                                           child: Icon(Icons
//                                                               .verified_user),
//                                                         )),
//                                                     SizedBox(height: 9.0),
//                                                     // User details
//                                                     Text(
//                                                       user[index].userName,
//                                                       style: TextStyle(
//                                                         color:
//                                                             AppColors.btnBlue,
//                                                         fontSize: 20.0,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                       ),
//                                                     ),
//                                                     Container(
//                                                       margin:
//                                                           const EdgeInsets.only(
//                                                               right: 10),
//                                                       child: Text(
//                                                         "User Id: ${user[index].userId}",
//                                                         style: TextStyle(
//                                                           fontSize: 14.0,
//                                                           color: Colors.grey,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Container(
//                                                       child: Text(
//                                                         "User Name: ${user[index].userName}",
//                                                         style: TextStyle(
//                                                           fontSize: 14.0,
//                                                           color: Colors.grey,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Container(
//                                                       margin:
//                                                           const EdgeInsets.only(
//                                                               right: 10),
//                                                       child: Text(
//                                                         "Gender: ${user[index].gender}",
//                                                         style: TextStyle(
//                                                           fontSize: 14.0,
//                                                           color: Colors.grey,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Container(
//                                                       margin:
//                                                           const EdgeInsets.only(
//                                                               right: 10),
//                                                       child: Text(
//                                                         "Age: ${user[index].age}",
//                                                         style: TextStyle(
//                                                           fontSize: 14.0,
//                                                           color: Colors.grey,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Container(
//                                                       child: Text(
//                                                         "Email:${user[index].email}",
//                                                         style: TextStyle(
//                                                           fontSize: 10.0,
//                                                           color: const Color
//                                                                   .fromARGB(
//                                                               255, 77, 77, 77),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             )),
//                                     child: Icon(
//                                       FontAwesomeIcons.circleInfo,
//                                       size: 22,
//                                       color: AppColors.btnBlue,
//                                       weight: 3,
//                                     ),
//                                   ),