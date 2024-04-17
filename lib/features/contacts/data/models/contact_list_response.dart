import 'package:chat_app/features/app_user/data/models/user_response.dart';
import 'package:chat_app/features/contacts/domain/entities/contact_list.dart';

import '../../../app_user/domain/entities/user.dart';

class ContactListResponse {
  final List<UserResponse> users;
  const ContactListResponse(this.users);

  ContactList toEntity() {
    return ContactList(
      users: List<User>.from(
        users.map((user) => user.toEntity()).toList(),
      ),
    );
  }
}
