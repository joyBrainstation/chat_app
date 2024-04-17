import 'package:chat_app/features/app_user/data/data_sources/app_user_data_source.dart';
import 'package:chat_app/features/app_user/data/data_sources/app_user_firebase_data_source.dart';
import 'package:chat_app/features/app_user/data/repositories/app_user_repository_impl.dart';
import 'package:chat_app/features/app_user/domain/repositories/app_user_repository.dart';
import 'package:chat_app/features/authentication/data/data_sources/authentication_data_source.dart';
import 'package:chat_app/features/authentication/data/data_sources/firebase_authentication_data_source.dart';
import 'package:chat_app/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:chat_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerFactory<AppUserDataSource>(() => AppUserFirebaseDataSource());

  sl.registerFactory<AppUserRepository>(
      () => AppUserRepositoryImpl(sl<AppUserDataSource>()));

  sl.registerFactory<AuthenticationDataSource>(
      () => FirebaseAuthenticationDataSource());

  sl.registerFactory<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      sl<AuthenticationDataSource>(),
    ),
  );
}
