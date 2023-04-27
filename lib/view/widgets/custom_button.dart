import 'package:flutter/material.dart';
import 'package:walkmate/utils/app_color.dart';

class CustomButton extends StatelessWidget {

  VoidCallback onPressed;
  Widget child;
  Color backgroundColor;

  CustomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.backgroundColor,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ///Re-Usable custom button
    ///Which we are using every where
    return SizedBox(width: double.infinity,height: 56.0,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48),side: const BorderSide(color: AppColor.green))
          ),
          child: child,

      ),
    );
  }
}
