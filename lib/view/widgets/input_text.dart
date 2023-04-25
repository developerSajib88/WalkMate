import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputText extends StatelessWidget {
  String text;
  Color color;
  InputText({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.manrope(fontSize: 16,color: color),
    );
  }
}
