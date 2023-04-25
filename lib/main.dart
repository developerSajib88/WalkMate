import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:walkmate/view/screens/splash_screen.dart';

import 'controller/notification_service.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await Hive.initFlutter();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
