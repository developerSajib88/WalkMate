import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walkmate/controller/theme/theme_controller.dart';
import 'package:walkmate/utils/app_constants.dart';
import 'package:walkmate/utils/font_styles.dart';
import 'package:walkmate/utils/images.dart';
import 'package:walkmate/view/widgets/theme_change_button.dart';

import '../../utils/app_color.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  final Color leftBarColor = AppColor.green;
  final Color rightBarColor = AppColor.green;
  final Color avgColor =
  AppColor.green;
  @override
  State<StatefulWidget> createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }


  ThemeModeController themeModeController = Get.put(ThemeModeController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ThemeModeController>(
        builder: (_) {
          return Container(width: double.infinity,height: double.infinity,padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
            color: themeModeController.darkTheme == false ? AppColor.light: AppColor.dark,
            child: SafeArea(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(children: [
                    InkWell(
                      onTap: ()=>Navigator.pop(context),
                      child: Image.asset(Images.backIc,width: 24,)
                    ),
                    const SizedBox(width: 10,),
                    Text(AppConstants.HISTORY,style: GoogleFonts.manrope(color: AppColor.green,fontWeight: FontWeight.w600,fontSize: 18),),
                    const Spacer(),
                    ThemeChangeButton(icon: Images.greenModeIc)

                  ],),
                  

                  const SizedBox(height: 30,),

                  Text(AppConstants.LAST_24.toUpperCase(),style: GoogleFonts.manrope(fontSize: 16,fontWeight: FontWeight.w600,
                  color: themeModeController.darkTheme == false? AppColor.dark: AppColor.light ),),
                  

                  SizedBox(width: double.infinity,height: 220,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const SizedBox(
                              height: 38,
                            ),
                            Expanded(
                              child: BarChart(
                                BarChartData(
                                  maxY: 20,
                                  barTouchData: BarTouchData(
                                    touchTooltipData: BarTouchTooltipData(
                                      tooltipBgColor: Colors.grey,
                                      getTooltipItem: (a, b, c, d) => null,
                                    ),
                                    touchCallback: (FlTouchEvent event, response) {
                                      if (response == null || response.spot == null) {
                                        setState(() {
                                          touchedGroupIndex = -1;
                                          showingBarGroups = List.of(rawBarGroups);
                                        });
                                        return;
                                      }

                                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                                      setState(() {
                                        if (!event.isInterestedForInteractions) {
                                          touchedGroupIndex = -1;
                                          showingBarGroups = List.of(rawBarGroups);
                                          return;
                                        }
                                        showingBarGroups = List.of(rawBarGroups);
                                        if (touchedGroupIndex != -1) {
                                          var sum = 0.0;
                                          for (final rod
                                          in showingBarGroups[touchedGroupIndex].barRods) {
                                            sum += rod.toY;
                                          }
                                          final avg = sum /
                                              showingBarGroups[touchedGroupIndex]
                                                  .barRods
                                                  .length;

                                          showingBarGroups[touchedGroupIndex] =
                                              showingBarGroups[touchedGroupIndex].copyWith(
                                                barRods: showingBarGroups[touchedGroupIndex]
                                                    .barRods
                                                    .map((rod) {
                                                  return rod.copyWith(
                                                      toY: avg, color: widget.avgColor);
                                                }).toList(),
                                              );
                                        }
                                      });
                                    },
                                  ),
                                  titlesData: FlTitlesData(
                                    show: true,
                                    rightTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 28,
                                        interval: 1,
                                        getTitlesWidget: leftTitles,
                                      ),
                                    ),

                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),

                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: bottomTitles,
                                        reservedSize: 42,
                                      ),
                                    ),

                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),


                                  ),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  barGroups: showingBarGroups,
                                  gridData: FlGridData(show: false),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
  
  

  Widget leftTitles(double value, TitleMeta meta) {

    String text;
    if (value == 0) {
      text = '0m';
    } else if (value == 10) {
      text = '500m';
    } else if (value == 19) {
      text = '1000m';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: chartTitleStyles(themeModeController.darkTheme == false? AppColor.dark: AppColor.light) ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['12am', '1', '2am', '3', '4am', '5', '6am'];

    final Widget text = Text(
      titles[value.toInt()],
      style: chartTitleStyles(themeModeController.darkTheme == false? AppColor.dark: AppColor.light),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
