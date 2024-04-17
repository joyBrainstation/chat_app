import 'package:chat_app/core/components/data/models/error_response.dart';
import 'package:chat_app/core/components/domain/entity/error_data.dart';
import 'package:chat_app/features/contacts/data/data_sources/contacts_data_source.dart';
import 'package:chat_app/features/contacts/data/models/contact_list_response.dart';
import 'package:chat_app/features/contacts/domain/entities/contact_list.dart';
import 'package:chat_app/features/contacts/domain/repositories/contact_repository.dart';
import 'package:dartz/dartz.dart';

class ContactRepositoryImpl extends ContactRepository {
  final ContactsDataSource _contactsDataSource;

  ContactRepositoryImpl(this._contactsDataSource);

  @override
  Future<Either<ContactList, ErrorData>> fetchContacts() async {
    Either<ContactListResponse, ErrorResponse> response =
        await _contactsDataSource.fetchContacts();

    return response.fold(
        (ContactListResponse contactListResponse) =>
            Left(contactListResponse.toEntity()),
        (ErrorResponse errorResponse) => Right(errorResponse.toEntity()));
  }
}
