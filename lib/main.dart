import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'app.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  // final NotificationAppLaunchDetails notificationAppLaunchDetails =
  //     await FlutterLocalNotificationsPlugin().getNotificationAppLaunchDetails();

  // const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('app_icon');
  
  

      
  await Firebase.initializeApp();
  
  runApp(App());
}



