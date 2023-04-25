
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

final TextStyle headerWhite = GoogleFonts.plusJakartaSans(
  color: Colors.white,
  fontSize: 36,
  fontWeight: FontWeight.bold,
);

final TextStyle headerGreen = GoogleFonts.plusJakartaSans(
  color: AppColor.green,
  fontSize: 36,
  fontWeight: FontWeight.bold
);

final TextStyle description1 = GoogleFonts.manrope(
  color: AppColor.light,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

final TextStyle description2 = GoogleFonts.manrope(
  color: AppColor.dark,
  fontSize: 18,
  fontWeight: FontWeight.normal,
);


TextStyle buttonTextStyle(Color color)=> GoogleFonts.manrope(
 color: color,
  fontWeight: FontWeight.w600,
  fontSize: 16

);


TextStyle chartTitleStyles(Color color)=> GoogleFonts.manrope(
    color: color,
    fontWeight: FontWeight.normal,
    fontSize: 12

);