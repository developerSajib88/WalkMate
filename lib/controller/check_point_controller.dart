import 'package:get/get.dart';
import 'package:hive/hive.dart';

class CheckPointController extends GetxController{

  double completedTarget = 0; ///How far completed walk
  bool completed = false; /// check target Completed or no
  List<dynamic> checkPointLiST = []; /// Check point list


  ///How far completed target updated this method
  void setCompletedTarget(double value)async{
    completedTarget = value;
    Box box = await Hive.openBox("CheckPointList");
    box.put("savecompletedTarget", completedTarget);
    update();
  }

  ///Save check point list in Local database and added element in list
 void setCheckPoint(String completed)async{
   checkPointLiST.add({"checkpoint" : completed});
   Box box = await Hive.openBox("CheckPointList");
   box.put("saveCheckPointList", checkPointLiST);
   update();
 }


 ///Check previous target completed or No completed and Save local database
  void checkMarkCompleted()async{
    Box box = await Hive.openBox("CheckPointList");
    box.put("completed", completed);
    update();
  }

 /// Update date from previous storage data
 void updateCheckPointList()async{
   Box box = await Hive.openBox("CheckPointList");
   checkPointLiST = box.get("saveCheckPointList");
   completed = box.get("completed");
   completedTarget = box.get("savecompletedTarget");
   update();
 }




}