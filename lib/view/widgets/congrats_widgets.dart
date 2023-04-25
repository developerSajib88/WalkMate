import 'package:flutter/cupertino.dart';

import '../../utils/images.dart';

class CongratsWidgets extends StatelessWidget {
  const CongratsWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 160,height: 160,
      child: Image.asset(Images.congratsImage),
    );
  }
}
