// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/colors.dart';
import '../../module/messagemodeule.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  List<MessageModule> messages = [
    MessageModule("assets/profile.jpg", "Mathematees",
        "I don't get you sir hbsddgfdbfdbfdbfbfbfbfdjhhdhdhdhdhdh"),
    MessageModule("assets/profile.jpg", "Mathematees", "I don't get you sir "),
    MessageModule("assets/profile.jpg", "Mathematees", "I don't get you sir "),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            centerTitle: true,
            title: Text(
              "Messages",
              style: GoogleFonts.montserrat(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue),
            ),
            leading: GestureDetector(
                onTap: () => Get.back(), child: Icon(Icons.arrow_back)),
          )),
      body: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return ListTile(
                leading: CircleAvatar(
                  // You can use an image here for the user profile picture
                  backgroundColor: Colors.blue,
                  child: Text(
                    messages[index]
                        .userProfileImage, // Display the first letter of the username
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(messages[index].userName),
                subtitle: Text(messages[index].message),
                onTap: () {
                  // Handle message tap action here
                  print('Tapped on message: ${messages[index].message}');
                });
          }),
    );
  }
}

