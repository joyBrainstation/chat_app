import 'package:chat_app/core/components/data/models/error_response.dart';
import 'package:chat_app/core/components/domain/entity/error_data.dart';
import 'package:chat_app/features/app_user/data/data_sources/app_user_data_source.dart';
import 'package:chat_app/features/app_user/data/models/user_response.dart';
import 'package:chat_app/features/app_user/domain/entities/user.dart';
import 'package:chat_app/features/app_user/domain/repositories/app_user_repository.dart';
import 'package:dartz/dartz.dart';

class AppUserRepositoryImpl extends AppUserRepository {
  final AppUserDataSource _appUserDataSource;

  AppUserRepositoryImpl(this._appUserDataSource);

  @override
  Either<User, ErrorData> fetchAppUserData() {
    Either<UserResponse, ErrorResponse> response =
        _appUserDataSource.fetchAppUserData();
    return response.fold((UserResponse user) => Left(user.toEntity()),
        (ErrorResponse error) => Right(error.toEntity()));
  }

  @override
  bool checkUserAuthentication() {
    return _appUserDataSource.checkUserAuthentication();
  }

  @override
  Future<void> logoutAppUser() async{
   await _appUserDataSource.logoutAppUser();
  }
}
