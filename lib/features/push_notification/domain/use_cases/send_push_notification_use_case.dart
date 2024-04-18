import 'package:chat_app/features/push_notification/domain/repositories/push_notification_repository.dart';

import '../../../../config/service_locator/service_locator.dart';
import '../../../app_user/domain/entities/user.dart';

class SendPushNotificationUseCase {
  Future<void> call(User user, String message) async {
    await sl<PushNotificationRepository>().sendPushNotification(user, message);
  }
}
