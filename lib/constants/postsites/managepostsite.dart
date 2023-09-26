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
  final _endTimeController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _reportCollection = FirebaseDatabase.instance.ref('Users');
  final _postCollection = FirebaseDatabase.instance.ref('GuardAllocations');
  final _locationCollection =
      FirebaseDatabase.instance.ref('PostSitesLocations');
  String? endTimeAll;
  String? startTimeAll;
  deleteMessage(key) {
    _reportCollection.child(key).remove();
  }

  DatabaseReference? dbRef;
  DatabaseReference? dbref;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Users');
    dbref = FirebaseDatabase.instance.ref().child('GuardAllocations');
  }

  int? selectedOption;
  String selectedGuard = " ";
  String selectedLocation = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Guard Allocations',
          style: TextStyle(fontSize: 19),
        ),
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
                                                                  leading:
                                                                      ImgRound(),
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
                          leading: ImgRound()),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
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
                                            stream: _locationCollection.onValue,
                                            builder: (context, snapShot) {
                                              if (snapShot.hasData &&
                                                  !snapShot.hasError &&
                                                  snapShot.data?.snapshot
                                                          .value !=
                                                      null) {
                                                Map _locateCollections =
                                                    snapShot.data?.snapshot
                                                        .value as Map;
                                                List _locateItems = [];
                                                _locateCollections.forEach(
                                                    (index, data) =>
                                                        _locateItems.add({
                                                          "key": index,
                                                          ...data
                                                        }));

                                                return ListView.builder(
                                                    itemCount:
                                                        _locateItems.length,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Card(
                                                              color:
                                                                  Colors.white,
                                                              elevation: 10,
                                                              child: ListTile(
                                                                  leading:
                                                                      locationRound(),
                                                                  subtitle: Text(
                                                                      _locateItems[
                                                                              index]
                                                                          [
                                                                          'location_Description']),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      selectedLocation =
                                                                          _locateItems[index]
                                                                              [
                                                                              'location_Name'];
                                                                    });
                                                                    Get.back();
                                                                  },
                                                                  title: Text(_locateItems[
                                                                          index]
                                                                      [
                                                                      'location_Name'])),
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
                          leading: locationRound()),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Card(
                  color: Colors.white,
                  elevation: 10,
                  child: FormBuilderDateTimePicker(
                    onSaved: (value) {
                      startTimeAll = value.toString();
                    },
                    controller: _startTimeController,
                    name: 'start_time',
                    inputType: InputType.time,
                    format: DateFormat('h:mm a'),
                    decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        label: Text(
                          "Choose Start Time",
                          style: TextStyle(fontSize: 12),
                        ),
                        contentPadding: EdgeInsets.all(18),
                        prefixIcon: Icon(Icons.alarm)),
                    onChanged: (value) {
                      assignment.startTime = value!;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  color: Colors.white,
                  elevation: 10,
                  child: FormBuilderDateTimePicker(
                    onSaved: (value) {
                      endTimeAll = value.toString();
                    },
                    controller: _endTimeController,
                    name: 'end_time',
                    inputType: InputType.time,
                    format: DateFormat('HH:mm'),
                    decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        label: Text(
                          "Choose End Time",
                          style: TextStyle(fontSize: 12),
                        ),
                        contentPadding: EdgeInsets.all(18),
                        prefixIcon: Icon(Icons.lock_clock)),
                    onChanged: (value) {
                      assignment.startTime = value!;
                    },
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.saveAndValidate()) {
                      Map<String, String> allocate = {
                        "Guard_Name": selectedGuard,
                        "Allocated_Location": selectedLocation,
                      };
                      dbref
                          ?.push()
                          .set(allocate)
                          .then((_) => Get.showSnackbar(GetSnackBar(
                                barBlur: 10,
                                borderRadius: 10,
                                duration: Duration(seconds: 3),
                                titleText: Text(
                                  "Guard Allocation Success",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                                message:
                                    "Guard ${selectedGuard} posted to ${selectedLocation}",
                                snackPosition: SnackPosition.TOP,
                                snackStyle: SnackStyle.GROUNDED,
                              )));
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

class locationRound extends StatelessWidget {
  const locationRound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.5),
        image: DecorationImage(
            image: AssetImage('assets/location.gif'), fit: BoxFit.cover),
      ),
    );
  }
}

class ImgRound extends StatelessWidget {
  const ImgRound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.5),
        image: DecorationImage(
            image: AssetImage('assets/guard.png'), fit: BoxFit.cover),
      ),
    );
  }
}

