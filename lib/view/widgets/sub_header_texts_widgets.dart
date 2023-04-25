
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubHeaderTextStyle extends StatelessWidget {
  String text;
  Color color;
  SubHeaderTextStyle({
    Key? key,
    required this.text,
    required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: GoogleFonts.manrope(
        color: color,fontSize: 16,fontWeight: FontWeight.w600,
      ),
    );
  }
}
