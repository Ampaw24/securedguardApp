// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:atusecurityapp/constants/textstyle.dart';
import 'package:atusecurityapp/constants/colors.dart';


class Annoucements extends StatefulWidget {
  const Annoucements({super.key});

  @override
  State<Annoucements> createState() => _AnnoucementsState();
}

class _AnnoucementsState extends State<Annoucements> {
  final TextEditingController _titleController = TextEditingController();

  List<String> _courses = [
    'All',
    'Course A',
    'Course B',
    'Course C',
    'Course D',
  ];
  String? _selectedCourse;
  List<DropdownMenuItem> getDropdownData() {
    List<DropdownMenuItem<String>> dropdownItem = [];
    for (var index = 0; index < _courses.length; index++) {
      String options = _courses[index];
      var dropItem = DropdownMenuItem(
          value: options,
          child: Text(
            options.toLowerCase(),
          ));
      dropdownItem.add(dropItem);
    }
    return dropdownItem;
  }

  final TextEditingController _announcementController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            title: Text(
              "Annoucement",
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.btnBlue),
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Announcement Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(
                        // filled: true,

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white))),
                    value: _selectedCourse,
                    elevation: 3,
                    items: getDropdownData(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCourse = value;
                      });
                    }),
                SizedBox(height: 30.0),
                TextField(
                  controller: _announcementController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Announcement',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    // Handle the announcement submission here
                    String announcement = _announcementController.text;
                    if (announcement.isNotEmpty) {
                      // You can send the announcement to a server, database, or perform any desired action.
                      // For now, we'll just print it.
                      print('Announcement: $announcement');
                      // Optionally, you can clear the text field.
                      _announcementController.clear();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    margin: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        "Send Announcement",
                        style: GoogleFonts.montserrat(
                         ),
                      ),
                    ),
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        color: AppColors.btnBlue,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
  // onPressed: () {
  //                   // Handle the announcement submission here
  //                   String announcement = _announcementController.text;
  //                   if (announcement.isNotEmpty) {
  //                     // You can send the announcement to a server, database, or perform any desired action.
  //                     // For now, we'll just print it.
  //                     print('Announcement: $announcement');
  //                     // Optionally, you can clear the text field.
  //                     _announcementController.clear();
  //                   }
  //                 },