import 'package:chat_app/core/components/data/models/error_response.dart';
import 'package:chat_app/features/app_user/data/models/user_response.dart';

import 'package:chat_app/features/contacts/data/models/contact_list_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'contacts_data_source.dart';

class ContactFirebaseDataSource extends ContactsDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<Either<ContactListResponse, ErrorResponse>> fetchContacts() async {
    try {
      final CollectionReference usersCollection =
          _firestore.collection('users');

      final QuerySnapshot snapshot = await usersCollection
          .where("id", isNotEqualTo: _firebaseAuth.currentUser?.uid)
          .get();

      List<UserResponse> users = List<UserResponse>.from(
        snapshot.docs.map(
          (doc) => UserResponse.fromJson(doc.data() as Map<String, dynamic>),
        ),
      );
      if(users.isEmpty){
        throw "No users found to chat with!";
      }
      return Left(ContactListResponse(users));
    } catch (e) {
      return Right(ErrorResponse(e.toString()));
    }
  }
}
