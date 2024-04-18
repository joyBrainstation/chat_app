import 'package:chat_app/features/app_user/data/models/user_response.dart';
import 'package:chat_app/features/app_user/domain/entities/user.dart';
import 'package:chat_app/features/push_notification/data/data_source/push_notification_data_source.dart';
import 'package:chat_app/features/push_notification/data/model/push_notification_response.dart';
import 'package:chat_app/features/push_notification/domain/entities/push_notification.dart';
import 'package:chat_app/features/push_notification/domain/repositories/push_notification_repository.dart';

class PushNotificationRepositoryImpl extends PushNotificationRepository {
  final PushNotificationDataSource _pushNotificationDataSource;
  PushNotificationRepositoryImpl(this._pushNotificationDataSource);
  @override
  void initializePushNotification() {
    _pushNotificationDataSource.initializePushNotification();
  }

  @override
  void onNotificationReceived(PushNotification notification) {
    PushNotificationResponse response =
        PushNotificationResponse(notification.title, notification.body);
    _pushNotificationDataSource.onNotificationReceived(response);
  }

  @override
  Future<bool> requestPermission() async {
    return await _pushNotificationDataSource.requestPermission();
  }

  @override
  Future<void> sendPushNotification(User user, String message) async {
    UserResponse userResponse = UserResponse(
      user.id,
      user.name,
      user.email,
      user.photo,
      user.token,
    );
    await _pushNotificationDataSource.sendPushNotification(
        userResponse, message);
  }
}
