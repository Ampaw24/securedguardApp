// ignore_for_file: sort_child_properties_last, prefer_const_constructors, use_build_context_synchronously
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors.dart';
import '../textstyle.dart';

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

  // final databaseRef = FirebaseDatabase.instance.ref('iii');
  // DataSnapshot dataSnapshot = databaseRef.once();
  // List<dynamic> values = dataSnapshot.value;
  // List<DropdownMenuItem<dynamic>> items = [];
  // values.forEach((value){
  //   items.add(DropdownMenuItem(
  //     value:value,
  //     child:Text(vallue),
  //   ))
  // });
  final _reportCollection = FirebaseDatabase.instance.ref('PostSitesLocations');

  deleteMessage(key) {
    _reportCollection.child(key).remove();
  }

  DatabaseReference? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance
        .ref()
        .child('PostSitesLocations/loacation_Id');
    print(dbRef);
  }

  Future<List<String>> fetchLocationsFromDatabase() async {
    DataSnapshot snapShot =
        (await _reportCollection.child('PostSitesLocations').once()).snapshot;
    List<String> locations = [];

    Map<String, String>? values = snapShot.value as Map<String, String>?;
    
    print(values);

    if (values != null) {
      values.forEach((key, value) {
        locations.add(value.toString());
      });
    } else {
      await showDialog(
          context: context,
          builder: (BuildContext ctx) => AlertDialog(
              title: Text('No Locations Found'), content: Text("Please Add")));
    }

    return locations;
  }

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
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: FormBuilderDropdown(
                    icon: Icon(Icons.security),
                    initialValue: "Guard 1",
                    elevation: 5,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.black,
                    ))),
                    name: 'guard_name',
                    items: ['Guard 1', 'Guard 2', 'Guard 3']
                        .map((guard) => DropdownMenuItem(
                              value: guard,
                              child: Text(guard),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        assignment.guardName = value.toString();
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                FutureBuilder<List<String>>(
                  future: fetchLocationsFromDatabase(),
                  builder: (context, snapShot) {
                    if (snapShot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapShot.hasError) {
                      return Text('Error: ${snapShot.error}');
                    } else {
                      List<String>? locations = snapShot.data;
                      return FormBuilderDropdown(
                        elevation: 5,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.black,
                        ))),
                        icon: Icon(Icons.location_on),
                        initialValue: "Location 1",
                        name: 'location_name',
                        items: locations!
                            .map((location) => DropdownMenuItem(
                                  value: location,
                                  child: Text(location),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            assignment.locationName = value.toString();
                          });
                        },
                      );
                    }
                  },
                ),
                FormBuilderDropdown(
                  elevation: 5,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.black,
                  ))),
                  icon: Icon(Icons.location_on),
                  initialValue: "Location 1",
                  name: 'location_name',
                  items: ['Location 1', 'Location 2', 'Location 3']
                      .map((location) => DropdownMenuItem(
                            value: location,
                            child: Text(location),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      assignment.locationName = value.toString();
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
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
                    print("readd");
                    if (_formKey.currentState!.saveAndValidate()) {
                      // Form data is valid, you can perform the assignment here.
                      print('Assignment Data:');
                      print('Guard Name: ${assignment.guardName}');
                      print('Location Name: ${assignment.locationName}');
                      print('Start Time: ${assignment.startTime}');
                      print('End Time: ${assignment.endTime}');
                    }

                    // Map<String,dynamic> GuardAssign = [
                    //   'Guard_Name':
                    // ];
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
