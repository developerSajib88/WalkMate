import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walkmate/controller/theme/theme_controller.dart';
import 'package:walkmate/utils/app_color.dart';
import 'package:walkmate/utils/app_constants.dart';
import 'package:walkmate/utils/font_styles.dart';
import 'package:walkmate/utils/images.dart';
import 'package:walkmate/view/screens/target_screen.dart';
import 'package:walkmate/view/widgets/custom_button.dart';

import '../widgets/header_text.dart';
import '../widgets/logo_widgets.dart';
import '../widgets/theme_change_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  ThemeModeController themeModeController = Get.put(ThemeModeController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    themeModeController.previousThemeMode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: GetBuilder<ThemeModeController>(
        builder: (_) {
          return Container(width: double.infinity,height: double.infinity,
            color: themeModeController.darkTheme == false? AppColor.greyLight: AppColor.dark,
            child: SafeArea(
              child: Stack(children: [
                const SizedBox(width: double.infinity,height: double.infinity,),
                Align(alignment: Alignment.bottomCenter,
                  child: Visibility(visible: themeModeController.darkTheme == false,
                      replacement: Image.asset(Images.menImageDark),
                      child: Image.asset(Images.menImageLight),
                  ),
                ),


                Container(width: double.infinity,height: double.infinity, padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 15),
                    child: Column(children: [

                      Row(children: [
                        LogoWidget( color: AppColor.green),
                        const Spacer(),
                        ThemeChangeButton(icon: Images.greenModeIc,)
                      ],),

                      const SizedBox(height: 30,),

                      HeaderText(
                        text: AppConstants.GOAL_TODAY,
                        color: themeModeController.darkTheme == false? AppColor.dark: AppColor.light,
                      ),

                      const Spacer(),
                      CustomButton(
                        onPressed: ()=>Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>const TargetScreen())),
                        backgroundColor: AppColor.green,
                        child: Text(AppConstants.GET_STARTED,style: buttonTextStyle(AppColor.light),),
                      ),
                    ],),
                )



              ],),
            ),
          );
        }
      ),
    );
  }
}
