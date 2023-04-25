import 'package:flutter/material.dart';
import 'package:walkmate/utils/app_constants.dart';

class LogoWidget extends StatelessWidget {
  Color color;
  LogoWidget({
    Key? key,
    required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppConstants.WALKMATE,
      style: TextStyle(color: color,fontWeight: FontWeight.bold,fontSize: 24),
    );
  }
}
