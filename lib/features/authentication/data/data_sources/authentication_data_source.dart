import 'package:chat_app/core/components/data/models/error_response.dart';
import 'package:chat_app/features/authentication/data/models/user_response.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationDataSource{
  Future<Either<UserResponse, ErrorResponse>> authenticate();


}