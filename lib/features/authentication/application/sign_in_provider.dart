import 'package:chat_app/core/components/domain/entity/error_data.dart';
import 'package:chat_app/core/components/domain/entity/no_input.dart';
import 'package:chat_app/features/authentication/domain/entities/user.dart';
import 'package:chat_app/features/authentication/domain/use_cases/sign_in_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signinProvider = Provider.family<SignInProvider, BuildContext>((ref, context) => SignInProvider(context: context));

final class SignInProvider {
  final BuildContext context;
  SignInProvider({required this.context,});

  Future<void> authenticate() async {
    SignInUseCase useCase = SignInUseCase();
    Either<User, ErrorData> response = await useCase(NoInput());
    response.fold((User user){
      //TODO:: go to landing page
    }, (ErrorData error) {
      //TODO:: implement error
    });
  }
}
