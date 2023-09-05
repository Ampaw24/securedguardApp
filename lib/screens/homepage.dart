// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../constants/textstyle.dart';
import '../widget/formfieldbox.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedItem = "Triad";
 TextEditingController hexCode = TextEditingController() ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),    
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 414,
                height: 170,
                child: Stack(
                  children: [
                    Positioned(
                        top: 20,
                        left: 20,
                        child: Text(
                          "Hi! Safo",
                          style: GoogleFonts.poppins(
                            textStyle: kHomewelcome,
                          ),
                        )),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.80,
                      top: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        width: 47,
                        height: 43,
                        child: Icon(
                          Icons.menu,
                          size: 25,
                          weight: 4,
                          color: Color.fromARGB(255, 126, 125, 125),
                        ),
                      ),
                    ),
                    Positioned(
                        left: 20,
                        top: 60,
                        child: Text(
                          "Explore The Best \nColor Scheme",
                          style:
                              GoogleFonts.poppins(textStyle: kHomeBannerText),
                        ))
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.86,
                  height: MediaQuery.of(context).size.height * 0.70,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                    color: GreenishgDarkTheme['themeColorDark'],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(35),
                        child: Text(
                          "Create Scheme",
                          style: GoogleFonts.poppins(textStyle: kcardNoteText2),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      FormFieldBox(
                          controller: hexCode,
                          prefixi: Icons.book,
                          hinttext: "Enter Color Hex Code"),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(29),
                      
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 25, top: 10),
                        child: Text(
                          "Nb: Kindly Remove the # from  \nColor code,\nClick the Center Round Button to \nGenerate.",
                          style: GoogleFonts.poppins(textStyle: kcardNoteText),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 0, 0, 0)
                                      .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                              color: Color.fromARGB(255, 240, 240, 240),
                              borderRadius: BorderRadius.circular(30)),
                          child: IconButton(
                              onPressed: () {
                              
                              },
                              icon: Icon(
                                Icons.check,
                                size: 30,
                                weight: 10,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
