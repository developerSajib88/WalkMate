import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walkmate/controller/theme/theme_controller.dart';
import 'package:walkmate/view/screens/target_screen.dart';
import 'package:walkmate/view/widgets/congrats_widgets.dart';
import 'package:walkmate/view/widgets/description_widgets.dart';

import '../../utils/app_color.dart';
import '../../utils/app_constants.dart';
import '../../utils/font_styles.dart';
import '../../utils/images.dart';
import '../widgets/custom_button.dart';
import '../widgets/header_text.dart';
import '../widgets/logo_widgets.dart';
import '../widgets/theme_change_button.dart';

class CongratulationScreen extends StatefulWidget {
  const CongratulationScreen({Key? key}) : super(key: key);

  @override
  State<CongratulationScreen> createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {

  ///GetX controller dependencies Injection
  ThemeModeController themeModeController = Get.put(ThemeModeController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ThemeModeController>(
          builder: (_) {
            return Container(width: double.infinity,height: double.infinity,
              color: themeModeController.darkTheme == false? AppColor.light: AppColor.dark,
              child: SafeArea(
                child: Container(width: double.infinity,height: double.infinity, padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 15),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                    ///Logo with Theme changing Button
                    Row(children: [
                      LogoWidget( color: AppColor.green),
                      const Spacer(),
                      ThemeChangeButton(icon: Images.greenModeIc,)
                    ],),

                    const SizedBox(height: 30,),

                    ///Congratulation Images
                    const CongratsWidgets(),

                    const SizedBox(height: 30,),

                    ///Congratulation Text
                    HeaderText(
                      text: AppConstants.CONGRATULATION,
                      color: AppColor.green,
                    ),

                    const SizedBox(height: 30,),

                    ///Details Text In congratulation Screen
                    const DescriptionWidget(),

                    const Spacer(),

                    ///Home Button
                    CustomButton(
                      onPressed: ()=>Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>const TargetScreen())),
                      backgroundColor: AppColor.green,
                      child: Text(AppConstants.HOME,style: buttonTextStyle(AppColor.light),),
                    ),
                  ],),
                ),
              ),
            );
          }
      ),
    );
  }
}
