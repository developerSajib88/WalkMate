import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walkmate/controller/check_point_controller.dart';
import 'package:walkmate/controller/theme/theme_controller.dart';
import 'package:walkmate/utils/app_color.dart';
import 'package:walkmate/utils/font_styles.dart';

class CheckPointList extends StatefulWidget {
  const CheckPointList({Key? key}) : super(key: key);

  @override
  State<CheckPointList> createState() => _CheckPointListState();
}

class _CheckPointListState extends State<CheckPointList> {

  ThemeModeController themeModeController = Get.put(ThemeModeController());
  CheckPointController checkPointController = Get.put(CheckPointController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckPointController>(
      builder: (_) {
        return ListView.builder(
            itemCount: checkPointController.checkPointLiST.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: GetBuilder<ThemeModeController>(
                  builder: (_) {
                    return Row(children: [
                      const Icon(Icons.flag,color: Colors.green,),
                      const SizedBox(width: 10,),
                      Text("Checkpoint ${index+1}",style: buttonTextStyle(themeModeController.darkTheme == false? AppColor.dark : AppColor.light),),
                      const Spacer(),
                      Text("${checkPointController.checkPointLiST[index]["checkpoint"]}m",style: GoogleFonts.manrope(fontSize: 14,fontWeight: FontWeight.w500,
                          color: themeModeController.darkTheme == false ?  AppColor.dark: AppColor.light),
                      ),

                    ],);
                  }
                ),
              );
            }
        );
      }
    );
  }
}
