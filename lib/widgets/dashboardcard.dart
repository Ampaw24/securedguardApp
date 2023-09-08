// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:atusecurityapp/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../constants/textstyle.dart';

class DashboarddCards extends StatelessWidget {
  final String title;
  final int counter;
  final IconData cardIcon;
  // final Color cardColor;
  final Widget navigatePage;

  const DashboarddCards(
      {super.key,
      required this.title,
      required this.cardIcon,
      required this.counter,
      required this.navigatePage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => navigatePage)),
      child: GlassmorphicContainer(
        borderRadius: 10,
        width: 170,
        height: 150,
        blur: 10,
        border: 0,
        borderGradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color(0xFF4579C5).withAlpha(100),
              Color(0xFFFFFFF).withAlpha(55),
              Color(0xFFF75035).withAlpha(10),
            ],
            stops: [
              0.06,
              0.95,
              1
            ]),
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 94, 191, 235),
              Color(0xFFffffff)
            ],
            stops: [
              0.3,
              1,
            ]),
        child: Stack(
          children: [
            Positioned(
              top: 15,
              left: 10,
              child: Text(title,
                  style: GoogleFonts.montserrat(textStyle: dashboardCardTitle)),
            ),
            Positioned(
              top: 90,
              left: 10,
              child: Text(counter.toString(),
                  style: GoogleFonts.montserrat(textStyle: dashboardCardcount)),
            ),
            Positioned(
                top: 80,
                left: 95,
                child: Container(
                  height: 40,
                  width: 38,
                  child: Icon(cardIcon, color: AppColors.btnBlue),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.45),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
