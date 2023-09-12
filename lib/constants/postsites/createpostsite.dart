// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:atusecurityapp/constants/colors.dart';
import 'package:atusecurityapp/constants/textstyle.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../modules/locationmodule.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _addressdController = TextEditingController();
  final List<Location> locations = [];
  final _newsCollection = FirebaseDatabase.instance.ref('PostSitesLocations');

  deleteMessage(key) {
    _newsCollection.child(key).remove();
  }

  DatabaseReference? dbRef;
  void _addLocation() {
    if (_formKey.currentState!.validate()) {
      final newLocation = Location(
        name: _nameController.text,
        address: _addressController.text,
      );
      setState(() {
        locations.add(newLocation);
        _nameController.clear();
        _addressController.clear();
        _addressdController.clear();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Post Sites');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Location Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/location.gif'),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          "\n Add Location ",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Location ID'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Location Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _addressdController,
                  decoration: InputDecoration(labelText: 'Location Description'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a decription of where location could be';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    Map<String, String> location = {
                     'loacation_Id': _nameController.text,
                     'location_Name': _addressController.text,
                     'location_Description': _addressdController.text
                    };
          
                    dbRef?.push().set(location).then((_) {
                      Flushbar(
                        title: "Annoucement Posted",
                        message: "Annoucement  posted",
                        duration: Duration(seconds: 4),
                        icon:
                            Icon(Icons.done_outline_rounded, color: Colors.white),
                        backgroundColor:
                            Color.fromARGB(255, 43, 51, 54).withOpacity(0.6),
                        flushbarPosition: FlushbarPosition.TOP,
                        animationDuration: Duration(milliseconds: 500),
                        borderRadius: BorderRadius.circular(10),
                        margin: EdgeInsets.all(8.0),
                        onTap: (flushbar) {
                          flushbar.dismiss();
                        },
                      ).show(context);
                    }).catchError((_) {
                      Flushbar(
                        title: "News Post Error",
                        message: "News  Error",
                        duration: Duration(seconds: 4),
                        icon:
                            Icon(Icons.done_outline_rounded, color: Colors.white),
                        backgroundColor:
                            Color.fromARGB(255, 237, 51, 51).withOpacity(0.6),
                        flushbarPosition: FlushbarPosition.TOP,
                        animationDuration: Duration(milliseconds: 300),
                        borderRadius: BorderRadius.circular(10),
                        margin: EdgeInsets.all(8.0),
                        onTap: (flushbar) {
                          flushbar.dismiss();
                        },
                      ).show(context);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    margin: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        "Add Location",
                        style: GoogleFonts.montserrat(
                            textStyle: subheaderBoldbtnwhite),
                      ),
                    ),
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        color: AppColors.cardBlue,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
