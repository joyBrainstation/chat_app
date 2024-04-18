
import '../../../app_user/domain/entities/user.dart';

abstract class PushNotificationRepository {
  Future<bool> requestPermission();

  void initializePushNotification();

  Future<void> sendPushNotification(User user, String message);

}
