// ignore_for_file: prefer_const_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../model/allocationsModel.dart';

class Allocations extends StatefulWidget {
  const Allocations({Key? key});

  @override
  State<Allocations> createState() => _AllocationsState();
}

class _AllocationsState extends State<Allocations> {
  final databaseReference = FirebaseDatabase.instance.reference();
  List<AllocationsModel> allocation = [];

  void fetchAllocations() {
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("GuardAllocations");
    reference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> allocationMap = event.snapshot.value as Map;
        List<AllocationsModel> updatedAllocation = [];

        allocationMap.forEach((key, value) {
          AllocationsModel allo =
              AllocationsModel.fromMap(key, value as Map<dynamic, dynamic>);
          updatedAllocation.add(allo);
        });

        setState(() {
          allocation = updatedAllocation;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAllocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Allocations'),
      ),
      body: ListView(
        children: allocation.map((allo) {
          TextAlign textAlign =
              allo.allocation.length > 20 ? TextAlign.left : TextAlign.right;

          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ExpansionTile(
              leading: Icon(Icons.notifications),
              title: Text(allo.guard),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Sector: ${allo.allocation.replaceAll("\\n", "\n")}",
                    style: TextStyle(fontSize: 16),
                    textAlign: textAlign,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Start Time: ${allo.startTime}",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "End Time: ${allo.endTime}",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
