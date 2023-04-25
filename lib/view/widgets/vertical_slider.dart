import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walkmate/controller/check_point_controller.dart';
import 'package:walkmate/utils/app_color.dart';

class VerticalSlider extends StatefulWidget {
  const VerticalSlider({Key? key}) : super(key: key);

  @override
  State<VerticalSlider> createState() => _VerticalSliderState();
}

class _VerticalSliderState extends State<VerticalSlider> {

  CheckPointController checkPointController = Get.put(CheckPointController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckPointController>(
      builder: (_) {
        return Stack(alignment: Alignment.center,
          children: [

            Container(width: 70,height: 182,color: AppColor.greyLight,),

            SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 65,
                  thumbShape: SliderComponentShape.noThumb,
                  overlayShape: SliderComponentShape.noThumb,
                  valueIndicatorShape: SliderComponentShape.noThumb,
                  trackShape: const RectangularSliderTrackShape(),
                ),

                child: RotatedBox(
                  quarterTurns: 135,
                  child: Slider(value: checkPointController.completedTarget,max: 10000,min: 0,
                    activeColor: AppColor.greyLight,inactiveColor: AppColor.green,
                    onChanged: (double value) => checkPointController.setCompletedTarget(value),

                  ),
                )
            ),
          ],
        );
      }
    );
  }
}
