import 'package:chat_app/core/components/domain/entity/error_data.dart';
import 'package:chat_app/core/components/domain/entity/no_input.dart';
import 'package:chat_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../config/service_locator/service_locator.dart';
import '../../../../core/components/domain/user_case/base_use_case.dart';
import '../entities/user.dart';

class SignInUseCase extends BaseUseCase<NoInput, User, ErrorData> {
  @override
  Future<Either<User, ErrorData>> call(NoInput input) async {
    return await sl.call<AuthenticationRepository>().authenticate(input);
  }
}
