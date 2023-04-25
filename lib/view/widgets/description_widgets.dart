
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walkmate/controller/theme/theme_controller.dart';
import 'package:walkmate/utils/app_constants.dart';

import '../../utils/app_color.dart';

class DescriptionWidget extends StatefulWidget {
  const DescriptionWidget({Key? key}) : super(key: key);

  @override
  State<DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {

  ThemeModeController themeModeController = Get.put(ThemeModeController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 300,
      child: GetBuilder<ThemeModeController>(
        builder: (_) {
          return Text(
            AppConstants.DETERMINATION,
            style: GoogleFonts.manrope(
                   color: themeModeController.darkTheme == false? AppColor.greyDark : AppColor.greyLight,
                   fontSize: 18,fontWeight: FontWeight.normal
            ),

          );
        }
      ),
    );
  }
}
