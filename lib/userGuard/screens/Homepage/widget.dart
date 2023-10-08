// // ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:ffi';

import 'package:flutter/material.dart';




class ExpandableTextWidget extends StatefulWidget {
  final String text;
  final int maxLines;

  ExpandableTextWidget({required this.text, this.maxLines = 3});

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: isExpanded ? null : widget.maxLines,
          overflow: isExpanded ? null : TextOverflow.ellipsis,
        ),
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? "Read Less" : "Read More",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}


// import '../../specs/arrays.dart';
// import '../../specs/colors.dart';


// class homeWidget extends StatelessWidget {
//   const homeWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: EdgeInsets.all(20),
//         height: 150,
//         width: 350,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10), color: GREEN),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 10.0, vertical: 10),
//                   child: Text(universitySecurityGuidelines.elementAt(index)['title']!),
//                 )
//               ],
//             ),
//             SizedBox(height: 5),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 10.0, vertical: 10),
//               child: Text("Content"),
//             )
//           ],
//         ));
//   }
// }