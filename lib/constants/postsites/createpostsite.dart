// ignore_for_file: prefer_const_constructors, sort_child_properties_last, non_constant_identifier_names

import 'package:atusecurityapp/constants/colors.dart';
import 'package:atusecurityapp/constants/textstyle.dart';
import 'package:atusecurityapp/module/locationmodule.dart';
import 'package:atusecurityapp/modules/guardassignmodule.dart';
import 'package:atusecurityapp/services/databasehandler.dart';
import 'package:atusecurityapp/services/databaselocationhelper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../modules/locationmodule.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

  bool _isLoading = false;
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
    dbRef = FirebaseDatabase.instance.ref().child('PostSitesLocations');
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
                  decoration:
                      InputDecoration(labelText: 'Location Description'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a decription of where location could be';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    _isLoading
                        ? SpinKitDualRing(
                            color: Colors.blue,
                          )
                        : Container();
                    final Locations model = Locations(
                        locationId: _nameController.text,
                        location_name: _addressdController.text);

                    Map<String, String> location = {
                      'loacation_Id': _nameController.text,
                      'location_Name': _addressController.text,
                      'location_Description': _addressdController.text
                    };

                    await dbRef?.push().set(location).then((_) async {
                      _nameController.text = "";
                      _addressController.text = " ";
                      _addressdController.text = " ";

                      await DbHelper.addLocation(model);
                      Get.showSnackbar(GetSnackBar(
                        title: "Location Added",
                        message:
                            "Location Added To database You can Assign Guards ",
                        duration: Duration(seconds: 5),
                      ));
                      setState(() {
                        _isLoading = false;
                      });
                    }).catchError((_) {
                      Get.showSnackbar(GetSnackBar(
                        title: "Error Occured ",
                        message: "Error Occured while Adding Location",
                        duration: Duration(seconds: 5),
                      ));
                    });
                    setState(() {
                      _isLoading = false;
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
