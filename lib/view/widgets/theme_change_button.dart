import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walkmate/controller/theme/theme_controller.dart';

class ThemeChangeButton extends StatefulWidget {

  String icon;

  ThemeChangeButton({
    Key? key,
    required this.icon
  }) : super(key: key);

  @override
  State<ThemeChangeButton> createState() => _ThemeChangeButtonState();
}

class _ThemeChangeButtonState extends State<ThemeChangeButton> {

  ThemeModeController themeModeController = Get.put(ThemeModeController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 30,height: 30,
      child: InkWell(
        onTap: ()=>themeModeController.changeTheme(),
        child: Center(child: Image.asset(widget.icon)),
      ),
    );
  }
}
