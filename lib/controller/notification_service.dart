import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:walkmate/controller/check_point_controller.dart';
import 'package:walkmate/view/screens/congratulation_screen.dart';
import 'package:walkmate/view/screens/no_completed.dart';

class NotificationService {

  CheckPointController checkPointController = Get.put(CheckPointController());

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('flutter_logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {
              ///For IOS
              /// When user Click Notification then check Target is completed or No
              /// If User can be target Is Completed so user navigate Congratulation Screen
              /// Other wise Mark go to Not Completed Screen
            if(checkPointController.completed == true){
              Get.to(const CongratulationScreen());
            }else{
              Get.to(const NotCompleted());
            }
            });

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {

              ///For Android
              /// When user Click Notification then check Target is completed or No
              /// If User can be target Is Completed so user navigate Congratulation Screen
              /// Other wise Mark go to Not Completed Screen
              if(checkPointController.completed == true){
                Get.to(const CongratulationScreen());
              }else{
                Get.to(const NotCompleted());
              }

            });
  }


  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  ///This method for calling when need to showing Flutter local Notification
  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }
}
