import 'package:dartz/dartz.dart';

import '../../../../core/components/domain/entity/error_data.dart';
import '../../../../core/components/domain/entity/no_input.dart';
import '../../../app_user/domain/entities/user.dart';

abstract class AuthenticationRepository {
  Future<Either<User, ErrorData>> authenticate(NoInput input);
}
