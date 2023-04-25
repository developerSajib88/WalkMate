import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walkmate/controller/target_limit_controller.dart';
import 'package:walkmate/controller/theme/theme_controller.dart';
import 'package:walkmate/utils/app_color.dart';
import 'package:walkmate/utils/font_styles.dart';
import 'package:walkmate/view/screens/check_point_screen.dart';
import 'package:walkmate/view/screens/history_screen.dart';
import 'package:walkmate/view/widgets/custom_button.dart';
import 'package:walkmate/view/widgets/header_text.dart';

import '../../utils/app_constants.dart';
import '../../utils/images.dart';
import '../widgets/custom_slider.dart';
import '../widgets/logo_widgets.dart';
import '../widgets/sub_header_texts_widgets.dart';
import '../widgets/theme_change_button.dart';

class TargetScreen extends StatefulWidget {
  const TargetScreen({Key? key}) : super(key: key);

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {

  ThemeModeController themeModeController = Get.put(ThemeModeController());
  TargetLimitController targetLimitController = Get.put(TargetLimitController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    targetLimitController.updateTarget();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ThemeModeController>(
        builder: (_) {
          return Container(width: double.infinity,height: double.infinity,
            color: themeModeController.darkTheme == false?AppColor.light : AppColor.dark,
          child: Column(children: [
            Container(width: double.infinity,height: 375,padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
              decoration: const BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(16), bottomLeft: Radius.circular(16)), color: AppColor.green,),
              child: Stack(
                children: [

                  Positioned(top: 0,right: 0,
                      child: Center(child: Image.asset(Images.pattern,width: 200,height: 200,fit: BoxFit.cover,))
                  ),

                  SafeArea(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        LogoWidget( color: AppColor.light),
                        const Spacer(),
                        ThemeChangeButton(icon: themeModeController.darkTheme == false? Images.whiteModeIc: Images.blackModeIc,)
                      ],),

                      const SizedBox(height: 30,),

                      HeaderText(text: AppConstants.GOAL_NOW, color: AppColor.light),

                      const SizedBox(height: 30,),

                      SizedBox(width: 300,
                          child: Text(
                            AppConstants.DETERMINATION,
                            style: description1,
                          )
                      ),







                    ],),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(children: [

                  SubHeaderTextStyle(text: AppConstants.ADD_TARGET,
                    color: themeModeController.darkTheme == false? AppColor.dark : AppColor.light,
                  ),


                  Expanded(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        const Spacer(),

                        const CustomSlider(
                          assetImage: Images.sliderIc,
                          inActiveTrackColor: AppColor.greyLight,
                          linearGradient: LinearGradient(colors: [AppColor.greyLight, AppColor.greyLight]),
                          trackHeight: 6.0,
                          max: 10000,
                          min: 0,
                          assetImageHeight: 40,
                          assetImageWidth: 40,
                          divisions: 100,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(children: [
                            Text("0m",style: GoogleFonts.manrope(fontSize: 14,fontWeight: FontWeight.w500,
                                color: themeModeController.darkTheme == false ?  AppColor.dark: AppColor.light),
                            ),

                            const Spacer(),

                            Text("10000m",style: GoogleFonts.manrope(fontSize: 14,fontWeight: FontWeight.w500,
                                color: themeModeController.darkTheme == false ?  AppColor.dark: AppColor.light),
                            ),


                          ],),
                        )

                      ],
                    ),
                  ),


                  const SizedBox(height: 50,),

                  Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(children: [
                      GetBuilder<TargetLimitController>(
                        builder: (_) {
                          return CustomButton(
                            onPressed: (){
                              if(targetLimitController.targetLimit >= 1000)Navigator.push(context, CupertinoPageRoute(builder: (context)=>const CheckPointScreen()));
                            },
                            backgroundColor: targetLimitController.targetLimit >= 1000 ? AppColor.green: themeModeController.darkTheme == false? AppColor.light: AppColor.dark,
                            child: Text(AppConstants.SET_LIMIT,style: buttonTextStyle(targetLimitController.targetLimit > 1000 ? AppColor.light: themeModeController.darkTheme == false? AppColor.grey: AppColor.light,),),
                          );
                        }
                      ),

                      const SizedBox(height: 15,),

                      CustomButton(
                        onPressed: ()=>Navigator.push(context, CupertinoPageRoute(builder: (context)=>const HistoryScreen())),
                        backgroundColor: themeModeController.darkTheme ==false? AppColor.light: AppColor.dark,
                        child: Text(AppConstants.HISTORY,style: buttonTextStyle(AppColor.green),),
                      ),
                    ],),
                  )

                ],),
              ),
            )

          ],),);
        }
      ),
    );
  }
}
