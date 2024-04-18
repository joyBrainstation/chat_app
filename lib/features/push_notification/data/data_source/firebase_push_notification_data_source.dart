import 'dart:convert';

import 'package:chat_app/features/app_user/data/models/user_response.dart';
import 'package:chat_app/features/push_notification/data/data_source/push_notification_data_source.dart';
import 'package:chat_app/features/push_notification/data/model/push_notification_response.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class FirebasePushNotificationDataSource extends PushNotificationDataSource {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _notificationPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<bool> requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
    );

    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  @override
  void onNotificationReceived(
      PushNotificationResponse notificationResponse) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    const androidNotificationDetails = AndroidNotificationDetails(
        'localpushnotification', 'localpushnotification channel',
        channelDescription: 'localpushnotification',
        importance: Importance.max,
        priority: Priority.high);

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _notificationPlugin.show(
      id,
      notificationResponse.title,
      notificationResponse.body,
      notificationDetails,
    );
  }

  @override
  void initializePushNotification() {
    const androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
    );

    _notificationPlugin.initialize(
      initializationSettings,
    );
  }

  @override
  Future<void> sendPushNotification(UserResponse user, String message) async {
    Map body = {
      "to": user.token,
      "notification": {"title": user.name, "body": message}
    };
    String serverKey =
        "AAAAYW_Vdmg:APA91bFmrX6XHQeDJJYGXZMSTs0vow4el1Z5A32FUA_D0KqX98CUnB5Kd8VohWQQ29NpWMbcxX3hDIVXrkMxSA0wHEBRvcMr0gAs6-qCw3pd_z58EmIPojT7KpKaMoWFaf-W4OdlSbuk";

    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(body));
  }
}
