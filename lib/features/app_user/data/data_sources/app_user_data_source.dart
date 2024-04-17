import 'package:chat_app/core/components/data/models/error_response.dart';
import 'package:chat_app/features/app_user/data/models/user_response.dart';
import 'package:dartz/dartz.dart';

abstract class AppUserDataSource {
  Either<UserResponse, ErrorResponse> fetchAppUserData();
  bool checkUserAuthentication();
  Future<void> logoutAppUser();
}
