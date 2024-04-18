import 'package:chat_app/features/app_user/data/models/user_response.dart';
import 'package:chat_app/features/push_notification/data/model/push_notification_response.dart';

abstract class PushNotificationDataSource {
  Future<bool> requestPermission();

  void onNotificationReceived(PushNotificationResponse notificationResponse);

  void initializePushNotification();

  Future<void> sendPushNotification(UserResponse user, String message);

}
