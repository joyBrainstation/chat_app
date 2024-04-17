import 'package:chat_app/core/components/domain/entity/error_data.dart';
import 'package:chat_app/features/contacts/domain/entities/contact_list.dart';
import 'package:dartz/dartz.dart';

abstract class ContactRepository {
  Future<Either<ContactList, ErrorData>> fetchContacts();
}
