import 'package:get/get.dart';
import 'package:hive/hive.dart';

class TargetLimitController extends GetxController{

  double targetLimit = 0; ///How far targeted user

  ///This method for User set target and Save target in local database
  void setTarget(double value)async{
    targetLimit = value;
    Box box = await Hive.openBox("target");
    box.put("targetLimit", targetLimit);
    update();
  }

  ///Previous target set from local database
  void updateTarget()async{
    Box box = await Hive.openBox("target");
    targetLimit = box.get("targetLimit");
    update();
  }

}