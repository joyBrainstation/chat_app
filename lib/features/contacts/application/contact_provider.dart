import 'package:chat_app/core/components/domain/entity/error_data.dart';
import 'package:chat_app/core/components/domain/entity/no_input.dart';
import 'package:chat_app/features/contacts/domain/entities/contact_list.dart';
import 'package:chat_app/features/contacts/domain/use_cases/fetch_contacts_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactsProvider =
    StateNotifierProvider<ContactsNotifier, AsyncValue<ContactList>>(
        (ref) => ContactsNotifier());

class ContactsNotifier extends StateNotifier<AsyncValue<ContactList>> {
  ContactsNotifier() : super(const AsyncLoading());

  Future<void> fetchContacts() async {
    FetchContactsUseCase useCase = FetchContactsUseCase();
    Either<ContactList, ErrorData> response = await useCase(NoInput());
    response.fold((ContactList contactList) {
      state = AsyncData(contactList);
    }, (ErrorData errorData) {
      state = AsyncError(errorData.message, StackTrace.current);
    });
  }
}
