import 'package:chat_app/features/push_notification/domain/entities/push_notification.dart';

import '../../../app_user/domain/entities/user.dart';

abstract class PushNotificationRepository {
  Future<bool> requestPermission();

  void onNotificationReceived(PushNotification notification);

  void initializePushNotification();

  Future<void> sendPushNotification(User user, String message);

}
