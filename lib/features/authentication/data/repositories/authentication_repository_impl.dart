import 'package:chat_app/core/components/data/models/error_response.dart';
import 'package:chat_app/core/components/domain/entity/error_data.dart';
import 'package:chat_app/core/components/domain/entity/no_input.dart';
import 'package:chat_app/features/authentication/data/data_sources/authentication_data_source.dart';
import 'package:chat_app/features/authentication/data/models/user_response.dart';
import 'package:chat_app/features/authentication/domain/entities/user.dart';
import 'package:chat_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationDataSource _authenticationDataSource;
  AuthenticationRepositoryImpl(this._authenticationDataSource);

  @override
  Future<Either<User, ErrorData>> authenticate(NoInput input) async {
    Either<UserResponse, ErrorResponse> response =
        await _authenticationDataSource.authenticate();

    return response.fold(
      (UserResponse user) => Left(
        user.toEntity(),
      ),
      (ErrorResponse error) => Right(
        error.toEntity(),
      ),
    );
  }
}
