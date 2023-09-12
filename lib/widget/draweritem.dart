// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {Key? key,
      required this.name,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  final String name;
  final IconData icon;

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        height: 45,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              SizedBox(
                width: 10,
                height: 5,
              ),
              Icon(
                icon,
                size: 18,
                color: const Color.fromARGB(255, 50, 50, 50),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                name,
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 50, 50, 50)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
