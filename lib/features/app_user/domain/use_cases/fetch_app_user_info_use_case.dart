import 'package:chat_app/core/components/domain/entity/error_data.dart';
import 'package:chat_app/features/app_user/domain/entities/user.dart';
import 'package:chat_app/features/app_user/domain/repositories/app_user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../config/service_locator/service_locator.dart';

class FetchAppUserInfoUseCase {
  Either<User, ErrorData> call() {
    return sl<AppUserRepository>().fetchAppUserData();
  }
}
