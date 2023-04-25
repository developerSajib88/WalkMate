import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walkmate/controller/check_point_controller.dart';
import 'package:walkmate/controller/notification_service.dart';
import 'package:walkmate/controller/target_limit_controller.dart';
import 'package:walkmate/controller/theme/theme_controller.dart';
import 'package:walkmate/utils/app_color.dart';
import 'package:walkmate/utils/font_styles.dart';
import 'package:walkmate/view/widgets/check_point_list.dart';
import 'package:walkmate/view/widgets/custom_button.dart';
import 'package:walkmate/view/widgets/header_text.dart';
import 'package:walkmate/view/widgets/input_text.dart';
import 'package:walkmate/view/widgets/vertical_slider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_constants.dart';
import '../../utils/images.dart';
import '../widgets/logo_widgets.dart';
import '../widgets/sub_header_texts_widgets.dart';
import '../widgets/theme_change_button.dart';

class CheckPointScreen extends StatefulWidget {
  const CheckPointScreen({Key? key}) : super(key: key);

  @override
  State<CheckPointScreen> createState() => _CheckPointScreenState();
}

class _CheckPointScreenState extends State<CheckPointScreen> {


  ThemeModeController themeModeController = Get.put(ThemeModeController());
  CheckPointController checkPointController = Get.put(CheckPointController());
  TargetLimitController targetLimitController = Get.put(TargetLimitController());


  /// check point adding controlling method
  void addCheckPoint(){
    var totalValue = checkPointController.completedTarget + checkPointController.completedTarget;
    if(checkPointController.completedTarget > 0 ){
      if(checkPointController.completedTarget >= targetLimitController.targetLimit.toInt() || totalValue > targetLimitController.targetLimit.toInt()){
        NotificationService().showNotification(title: AppConstants.TARGET_COMPLETE, body: "You covered ${targetLimitController.targetLimit.toInt()}m - WalkMate");
        checkPointController.setCompletedTarget(0);
        checkPointController.completed = true;
        checkPointController.checkPointLiST.clear();
        checkPointController.checkMarkCompleted();
        checkPointController.setCheckPoint(checkPointController.completedTarget.toInt().toString());
      }else{
        if(totalValue > 10000){
          NotificationService().showNotification(title: AppConstants.TARGET_COMPLETE, body: "You covered ${targetLimitController.targetLimit.toInt()}m - WalkMate");
          checkPointController.setCompletedTarget(0);
          checkPointController.completed = true;
          checkPointController.checkPointLiST.clear();
          checkPointController.checkMarkCompleted();
          checkPointController.setCheckPoint(checkPointController.completedTarget.toInt().toString());
        }else{
          checkPointController.completedTarget += checkPointController.completedTarget;
          checkPointController.setCheckPoint(checkPointController.completedTarget.toInt().toString());
        }
      }
    }
  }



  ///Mark As Completed button controller
  void markAsCompletedButtonController() {

    if(checkPointController.completedTarget >= 1000 && checkPointController.completedTarget < targetLimitController.targetLimit ){
      targetLimitController.setTarget(0);
      checkPointController.completed = false;
      checkPointController.checkMarkCompleted();
      checkPointController.setCompletedTarget(0);
      checkPointController.checkPointLiST.clear();
      checkPointController.setCheckPoint(checkPointController.completedTarget.toInt().toString());
      Navigator.pop(context);
      NotificationService().showNotification(title: AppConstants.TARGET_NO_COMPLETED,body: "You can not covered - WalkMate");
    }

    /*if (checkPointController.completed == true) {
      targetLimitController.setTarget(0);
      Navigator.pop(context);
      checkPointController.completed = false;
      checkPointController.checkMarkCompleted();
    }else{
      targetLimitController.setTarget(0);
      checkPointController.checkMarkCompleted();
      Navigator.push(context, CupertinoPageRoute(builder: (context)=>const NotCompleted()));
    }*/
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///Update date from previous storage data in local database
    checkPointController.updateCheckPointList();

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



                          Row(children: [
                            const Expanded(flex: 1,
                                child:  VerticalSlider(),
                            ),

                            const SizedBox(width: 30,),

                            Expanded(flex: 2,
                              child: GetBuilder<CheckPointController>(
                                builder: (_) {
                                  return Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                    InputText(text: AppConstants.COMPLETED, color: AppColor.light),
                                    Row(
                                      children: [
                                        HeaderText(text: checkPointController.completedTarget.toInt().toString(), color: AppColor.light),
                                        Text("m",style: GoogleFonts.manrope(color: AppColor.light,fontSize: 24,fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                    const SizedBox(height: 50,),
                                    InputText(text: AppConstants.TARGET, color: AppColor.light),
                                    Row(
                                      children: [
                                        HeaderText(text: targetLimitController.targetLimit.toInt().toString(), color: AppColor.greyLight),
                                        Text("m",style: GoogleFonts.manrope(color: AppColor.greyLight,fontSize: 24,fontWeight: FontWeight.bold),)
                                      ],
                                    ),

                                  ],);
                                }
                              ),
                            ),

                          ],)








                        ],),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 15),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                      SubHeaderTextStyle(text: AppConstants.CHECKPOINT,
                        color: themeModeController.darkTheme == false? AppColor.dark : AppColor.light,
                      ),

                      const Divider(color: AppColor.greyLight,),

                      const Expanded(
                          child: CheckPointList(),
                      ),

                      const SizedBox(height: 10,),

                      CustomButton(
                        onPressed: ()=> addCheckPoint(),
                        backgroundColor: AppColor.green,
                        child: Text(AppConstants.ADD_CHECKPOINT,style: buttonTextStyle(AppColor.light),),
                      ),

                      const SizedBox(height: 15,),

                      CustomButton(
                        onPressed: ()=>markAsCompletedButtonController(),
                        backgroundColor: themeModeController.darkTheme ==false? AppColor.light: AppColor.dark,
                        child: Text(AppConstants.MARK_COMPLETED,style: buttonTextStyle(AppColor.green),),
                      ),

                    ],),
                  ),
                )

              ],),
            );
          }
      ),
    );
  }
}
