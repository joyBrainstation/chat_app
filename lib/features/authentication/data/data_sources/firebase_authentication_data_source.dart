import 'package:chat_app/common/utils/constants.dart';
import 'package:chat_app/core/components/data/models/error_response.dart';
import 'package:chat_app/features/authentication/data/data_sources/authentication_data_source.dart';
import 'package:chat_app/features/app_user/data/models/user_response.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseAuthenticationDataSource extends AuthenticationDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Future<Either<UserResponse, ErrorResponse>> authenticate() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        if (userCredential.user != null) {
          final user = UserResponse(
            userCredential.user!.uid,
            userCredential.user!.displayName ?? '',
            userCredential.user!.email ?? '',
            userCredential.user!.photoURL ?? '',
            null,
          );

          Either<UserResponse, ErrorResponse> saveUserData =
              await _saveUserDataToFirestore(user);
          return saveUserData;
        } else {
          throw Constants.loginFailedMessage;
        }
      }
    } catch (e) {
      return Right(ErrorResponse(e.toString()));
    }

    return Right(ErrorResponse(Constants.loginFailedMessage));
  }

  Future<Either<UserResponse, ErrorResponse>> _saveUserDataToFirestore(
      UserResponse user) async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        //set fcm token to user
        user.token = token;

        final CollectionReference usersCollection =
            _firestore.collection('users');

        await usersCollection.doc(user.id).set(user.toJson());

        return Left(user);
      } else {
        throw "Could not get FCM token";
      }
    } catch (e) {
      return Right(ErrorResponse(e.toString()));
    }
  }
}
