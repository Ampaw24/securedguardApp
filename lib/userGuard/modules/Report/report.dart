// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:atusecurityapp/userGuard/model/userModel.dart';
import 'package:atusecurityapp/userGuard/specs/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../providers/userDetailsProvider.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  int _currentStep = 0;
  TextEditingController crimeSelectionController = TextEditingController();
  TextEditingController personalInfoController = TextEditingController();
  TextEditingController crimeInfoController = TextEditingController();
  TextEditingController evidenceInfoController = TextEditingController();
  TextEditingController addressInfoController = TextEditingController();
  TextEditingController locationInfoController = TextEditingController();
  UserModel? usernames;
  bool _areFormFieldsValid() {
    return crimeSelectionController.text.isNotEmpty &&
        personalInfoController.text.isNotEmpty &&
        addressInfoController.text.isNotEmpty &&
        crimeInfoController.text.isNotEmpty &&
        locationInfoController.text.isNotEmpty &&
        evidenceInfoController.text.isNotEmpty;
  }

  void _clearFormFields() {
    crimeSelectionController.text = "";
    personalInfoController.text = "";
    addressInfoController.text = "";
    crimeInfoController.text = "";
    locationInfoController.text = "";
    evidenceInfoController.text = "";
  }

  @override
  void dispose() {
    super.dispose();
  }

  DatabaseReference? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Victim Report');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Report '),
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepTapped: (step) {
          setState(() {
            _currentStep = step;
          });
        },
        onStepContinue: () {
          if (_currentStep < 3) {
            setState(() {
              _currentStep++;
            });
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep--;
            });
          }
        },
        steps: [
          Step(
            title: Text('Report Selection'),
            content: Column(
              children: [
                TextFormField(
                  controller: crimeSelectionController,
                  decoration: InputDecoration(
                      labelText: 'Type of Crime', border: OutlineInputBorder()),
                ),
              ],
            ),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: Text('Personal Information'),
            content: Column(
              children: [
                TextFormField(
                  controller: personalInfoController,
                  decoration: InputDecoration(
                      labelText: 'Name', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: addressInfoController,
                  decoration: InputDecoration(
                      labelText: 'Address', border: OutlineInputBorder()),
                ),
              ],
            ),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: Text('Report Information'),
            content: Column(
              children: [
                TextFormField(
                  controller: crimeInfoController,
                  decoration: InputDecoration(
                      labelText: 'Date of Crime', border: OutlineInputBorder()),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: locationInfoController,
                  decoration: InputDecoration(
                      labelText: 'Location of Crime',
                      border: OutlineInputBorder()),
                ),
              ],
            ),
            isActive: _currentStep >= 2,
          ),
          Step(
            title: Text('Evidence Information'),
            content: Column(
              children: [
                TextFormField(
                  controller: evidenceInfoController,
                  decoration: InputDecoration(
                      labelText: 'Description of Evidence',
                      border: OutlineInputBorder()),
                ),
              ],
            ),
            isActive: _currentStep >= 3,
          ),
        ],
      ),
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              if (_areFormFieldsValid()) {
                var username = userModel?.data?.name.toString() ?? "$usernames";
                Map<String, String> victimreport = {
                  'crimeSelection': crimeSelectionController.text,
                  'victimName': personalInfoController.text,
                  'Address': addressInfoController.text,
                  'date-of-crime': crimeInfoController.text,
                  'location': locationInfoController.text,
                  'evidence': evidenceInfoController.text,
                  'username': username,
                };
                dbRef?.push().set(victimreport).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Report has been Submitted Successfully.'),
                      duration: Duration(seconds: 4),
                    ),
                  );

                  _clearFormFields();

                  setState(() {});
                }).catchError((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Report Post Error. Check and make a report again.'),
                      duration: Duration(seconds: 4),
                    ),
                  );
                });
              } else {
                // Show a Snackbar for empty fields.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please fill all form fields.'),
                    duration: Duration(seconds: 4),
                  ),
                );
              }
            },
            child: Container(
              width: 250,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: GREEN),
              child: Center(
                child: Text(
                  'Submit',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: WHITE),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
