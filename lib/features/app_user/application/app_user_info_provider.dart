import 'package:chat_app/core/components/domain/entity/error_data.dart';
import 'package:chat_app/features/app_user/domain/use_cases/fetch_app_user_info_use_case.dart';
import 'package:chat_app/features/app_user/domain/use_cases/logout_app_user_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/entities/user.dart';

final appUserInfoProvider = Provider.family<AppUserInfoProvider, BuildContext>(
    (ref, context) => AppUserInfoProvider(context: context));

class AppUserInfoProvider {
  final BuildContext context;

  AppUserInfoProvider({required this.context});

  User? fetchUserData() {
    FetchAppUserInfoUseCase fetchAppUserInfoUseCase = FetchAppUserInfoUseCase();
    Either<User, ErrorData> response = fetchAppUserInfoUseCase();
    return response.fold((User user) => user, (r) {
      return null;
      //TODO:: handle error
    });
  }

  Future<void> logoutUser() async {
    LogoutAppUserUseCase logoutAppUserUseCase = LogoutAppUserUseCase();
    await logoutAppUserUseCase();
    if (context.mounted) {
      GoRouter.of(context).go("/");
    }
  }
}
