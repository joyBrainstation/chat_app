import 'package:chat_app/core/components/data/models/error_response.dart';
import 'package:dartz/dartz.dart';
import '../../../app_user/data/models/user_response.dart';

abstract class AuthenticationDataSource{
  Future<Either<UserResponse, ErrorResponse>> authenticate();


}