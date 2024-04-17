import 'package:chat_app/features/app_user/domain/repositories/app_user_repository.dart';

import '../../../../config/service_locator/service_locator.dart';

class LogoutAppUserUseCase {
  Future<void> call() async {
    await sl<AppUserRepository>().logoutAppUser();
  }
}
