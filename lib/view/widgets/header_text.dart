
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderText extends StatelessWidget {
  String text;
  Color color;
  HeaderText({
    Key? key,
    required this.text,
    required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.plusJakartaSans(
        color: color,fontSize: 36,fontWeight: FontWeight.bold
      ),
    );
  }
}
