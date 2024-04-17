import 'package:chat_app/core/components/domain/entity/error_data.dart';
import 'package:chat_app/core/components/domain/entity/no_input.dart';
import 'package:dartz/dartz.dart';

import '../entities/user.dart';

abstract class AppUserRepository{
  Either<User, ErrorData> fetchAppUserData();
  bool checkUserAuthentication();
  Future<void> logoutAppUser();
}