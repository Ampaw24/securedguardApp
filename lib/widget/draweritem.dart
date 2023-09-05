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
        height: 40,
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: Colors.black,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                name,
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
