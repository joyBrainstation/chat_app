import 'package:chat_app/core/components/data/models/error_response.dart';
import 'package:chat_app/features/contacts/data/models/contact_list_response.dart';
import 'package:dartz/dartz.dart';

abstract class ContactsDataSource{
  Future<Either<ContactListResponse, ErrorResponse>> fetchContacts();
}