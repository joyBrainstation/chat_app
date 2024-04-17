import 'package:chat_app/core/components/data/models/error_response.dart';
import 'package:chat_app/features/app_user/data/data_sources/app_user_data_source.dart';
import 'package:chat_app/features/app_user/data/models/user_response.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppUserFirebaseDataSource extends AppUserDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Either<UserResponse, ErrorResponse> fetchAppUserData() {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      UserResponse userResponse = UserResponse(
        user.uid,
        user.displayName ?? '',
        user.email ?? '',
        user.photoURL ?? '',
        null,
      );

      return Left(userResponse);
    } else {
      return Right(
        ErrorResponse("Could not find user"),
      );
    }
  }

  @override
  bool checkUserAuthentication() {
    return _firebaseAuth.currentUser != null;
  }

  @override
  Future<void> logoutAppUser() async {
    await _firebaseAuth.signOut();
  }
}
