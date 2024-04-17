import 'package:chat_app/core/components/domain/entity/error_data.dart';
import 'package:chat_app/core/components/domain/entity/no_input.dart';
import 'package:chat_app/core/components/domain/user_case/base_use_case.dart';
import 'package:chat_app/features/contacts/domain/entities/contact_list.dart';
import 'package:chat_app/features/contacts/domain/repositories/contact_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../config/service_locator/service_locator.dart';

class FetchContactsUseCase
    extends BaseUseCase<NoInput, ContactList, ErrorData> {
  @override
  Future<Either<ContactList, ErrorData>> call(NoInput input) async {
    return await sl<ContactRepository>().fetchContacts();
  }
}
