import 'package:chat_app/features/app_user/domain/use_cases/app_user_authentication_check_use_case.dart';
import 'package:chat_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:chat_app/features/chat/presentation/screens/chat_screen.dart';
import 'package:chat_app/features/contacts/presentation/screens/contact_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/app_user/domain/entities/user.dart';
import 'error_screen.dart';

class RouteGenerator {
  static final GoRouter router = GoRouter(
    errorBuilder: (context, state) {
      return const ErrorPage();
    },
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) {
          bool userAuthenticated = AppUserAuthenticationCheckUseCase().call();
          if (userAuthenticated) {
            return "/${ContactScreen.path}";
          } else {
            return "/${LoginScreen.path}";
          }
        },
      ),
      GoRoute(
        name: LoginScreen.path,
        path: "/${LoginScreen.path}",
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
          name: ContactScreen.path,
          path: "/${ContactScreen.path}",
          builder: (context, state) => const ContactScreen(),
          routes: [
            GoRoute(
                name: ChatScreen.path,
                path: ChatScreen.path,
                builder: (context, state) {
                  User user = state.extra as User;
                  return ChatScreen(user: user);
                })
          ])
    ],
  );
}
