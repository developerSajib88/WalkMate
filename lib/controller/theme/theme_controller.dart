import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ThemeModeController extends GetxController{

  bool darkTheme = true;

  ///Theme mode controlling method
  void changeTheme()async{
    if(darkTheme){
      darkTheme = false;
      update();
    }else{
      darkTheme = true;
      update();
    }


    ///Save Theme mode in Local Database
    Box box = await Hive.openBox("ThemeMode");
    box.put("saveMode", darkTheme);
    update();
  }

  ///Latest changing Mode method
  previousThemeMode()async{
    Box box = await Hive.openBox("ThemeMode");
    darkTheme = box.get("saveMode");
    update();
  }

}