import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class MyNotification {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('ic_launcher');
    Permission.notification.request();
    var iOSInitialize = DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
    );
  }

  static late String? url;
}

Future<void> showTextNotification(
    String title, String body, FlutterLocalNotificationsPlugin fln) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    playSound: true,
    importance: Importance.max,
    priority: Priority.max,
    sound: RawResourceAndroidNotificationSound('notification'),
  );
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails());
  void resylt = await fln.show(
    12323,
    title,
    body,
    platformChannelSpecifics,
  );
  print("Notification Sned");
}
