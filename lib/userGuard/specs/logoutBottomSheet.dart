import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void _showLogoutBottomSheet(BuildContext context) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) {
      return CupertinoActionSheet(
        title: Text('Logout'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              // Add your logout logic here
              // For example, you can sign the user out and navigate to the login page.
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
              Navigator.of(context).pop(); // Close the bottom sheet
            },
            child: Text('Logout'),
            isDestructiveAction: true, // Shows the action in red color
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop(); // Close the bottom sheet
          },
          child: Text('Cancel'),
        ),
      );
    },
  );
}
