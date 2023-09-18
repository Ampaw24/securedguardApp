// ignore_for_file: sort_child_properties_last, prefer_const_constructors, no_leading_underscores_for_local_identifiers

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
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                _userCollections.forEach(
                    (index, data) => _userItems.add({"key": index, ...data}));
                _total_guards = _userItems.length;
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
                            trailing: GestureDetector(child: Icon(Icons.info)),
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
    );
  }
}
