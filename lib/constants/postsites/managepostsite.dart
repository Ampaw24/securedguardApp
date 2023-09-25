// ignore_for_file: sort_child_properties_last, prefer_const_constructors, use_build_context_synchronously, no_leading_underscores_for_local_identifiers
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors.dart';
import '../textstyle.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';

class GuardLocationAssignment {
  String guardName = "";
  String locationName = "";
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
}

class AssignmentForm extends StatefulWidget {
  @override
  _AssignmentFormState createState() => _AssignmentFormState();
}

class _AssignmentFormState extends State<AssignmentForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  GuardLocationAssignment assignment = GuardLocationAssignment();

  final _reportCollection = FirebaseDatabase.instance.ref('Users');

  deleteMessage(key) {
    _reportCollection.child(key).remove();
  }

  DatabaseReference? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Users');
    print(dbRef);
  }

  int? selectedOption;
  String selectedGuard = " ";
  String selectedLocation = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guard Assignment'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    Card(
                      elevation: 10.0,
                      color: Colors.white,
                      child: ListTile(
                          title: Text(
                            "Select Guard",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text("Selected: ${selectedGuard}",
                              style: GoogleFonts.poppins(
                                  color: const Color.fromARGB(255, 30, 30, 30),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w200)),
                          trailing: IconButton(
                              onPressed: () {
                                Get.bottomSheet(
                                  enableDrag: true,
                                  isDismissible: true,
                                  SingleChildScrollView(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.70,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: SafeArea(
                                        child: StreamBuilder(
                                            stream: _reportCollection.onValue,
                                            builder: (context, snapShot) {
                                              if (snapShot.hasData &&
                                                  !snapShot.hasError &&
                                                  snapShot.data?.snapshot
                                                          .value !=
                                                      null) {
                                                Map _locationCollections =
                                                    snapShot.data?.snapshot
                                                        .value as Map;
                                                List _locationItems = [];
                                                _locationCollections.forEach(
                                                    (index, data) =>
                                                        _locationItems.add({
                                                          "key": index,
                                                          ...data
                                                        }));

                                                return ListView.builder(
                                                    itemCount:
                                                        _locationItems.length,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Card(
                                                              color:
                                                                  Colors.white,
                                                              elevation: 10,
                                                              child: ListTile(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      selectedGuard =
                                                                          _locationItems[index]
                                                                              [
                                                                              'name'];
                                                                    });
                                                                    Get.back();
                                                                  },
                                                                  title: Text(_locationItems[
                                                                          index]
                                                                      [
                                                                      'name'])),
                                                            ));
                                              }

                                              return Container();
                                            }),
                                      ),
                                    ),
                                  ),
                                  isScrollControlled: true,
                                );
                              },
                              icon: Icon(Icons.move_down)),
                          leading: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.5),
                              image: DecorationImage(
                                  image: AssetImage('assets/guard.png'),
                                  fit: BoxFit.cover),
                            ),
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ListView(
                  shrinkWrap: true,
                  children: [
                    Card(
                      elevation: 10.0,
                      color: Colors.white,
                      child: ListTile(
                          title: Text(
                            "Choose Location",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text("Selected: ${selectedLocation}",
                              style: GoogleFonts.poppins(
                                  color: const Color.fromARGB(255, 30, 30, 30),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w200)),
                          trailing: IconButton(
                              onPressed: () {
                                Get.bottomSheet(
                                  enableDrag: true,
                                  isDismissible: true,
                                  SingleChildScrollView(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.70,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: SafeArea(
                                        child: StreamBuilder(
                                            stream: _reportCollection.onValue,
                                            builder: (context, snapShot) {
                                              if (snapShot.hasData &&
                                                  !snapShot.hasError &&
                                                  snapShot.data?.snapshot
                                                          .value !=
                                                      null) {
                                                Map _locationCollections =
                                                    snapShot.data?.snapshot
                                                        .value as Map;
                                                List _locationItems = [];
                                                _locationCollections.forEach(
                                                    (index, data) =>
                                                        _locationItems.add({
                                                          "key": index,
                                                          ...data
                                                        }));

                                                return ListView.builder(
                                                    itemCount:
                                                        _locationItems.length,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Card(
                                                              color:
                                                                  Colors.white,
                                                              elevation: 10,
                                                              child: ListTile(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      selectedGuard =
                                                                          _locationItems[index]
                                                                              [
                                                                              'name'];
                                                                    });
                                                                    Get.back();
                                                                  },
                                                                  title: Text(_locationItems[
                                                                          index]
                                                                      [
                                                                      'name'])),
                                                            ));
                                              }

                                              return Container();
                                            }),
                                      ),
                                    ),
                                  ),
                                  isScrollControlled: true,
                                );
                              },
                              icon: Icon(Icons.move_down)),
                          leading: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.5),
                              image: DecorationImage(
                                  image: AssetImage('assets/location.gif'),
                                  fit: BoxFit.cover),
                            ),
                          )),
                    ),
                  ],
                ),
                FormBuilderDateTimePicker(
                  name: 'start_time',
                  inputType: InputType.time,
                  format: DateFormat('h:mm a'),
                  decoration: const InputDecoration(
                      labelText: 'Start Time', icon: Icon(Icons.alarm)),
                  onChanged: (value) {
                    assignment.startTime = value!;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                FormBuilderDateTimePicker(
                  name: 'end_time',
                  inputType: InputType.time,
                  format: DateFormat('h:mm a'),
                  decoration: const InputDecoration(
                      icon: Icon(Icons.lock_clock), labelText: 'End Time'),
                  onChanged: (value) {
                    assignment.endTime = value!;
                  },
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.saveAndValidate()) {
                      // Form data is valid, you can perform the assignment here.
                      print('Assignment Data:');
                      print('Guard Name: ${assignment.guardName}');
                      print('Location Name: ${assignment.locationName}');
                      print('Start Time: ${assignment.startTime}');
                      print('End Time: ${assignment.endTime}');
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    margin: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        "Assign Guard",
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

void showGuardPop() {
  Get.defaultDialog(
      title: "Welcome to Flutter Dev'S",
      middleText:
          "FlutterDevs is a protruding flutter app development company with "
          "an extensive in-house team of 30+ seasoned professionals who know "
          "exactly what you need to strengthen your business across various dimensions",
      backgroundColor: Colors.white,
      titleStyle: TextStyle(color: Colors.white),
      middleTextStyle: TextStyle(color: Colors.white),
      radius: 10);
}
