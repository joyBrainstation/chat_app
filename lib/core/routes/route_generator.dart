import 'package:chat_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

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
          return "/${LoginScreen.path}";
        },
      ),
      GoRoute(
        name: LoginScreen.path,
        path: "/${LoginScreen.path}",
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
}
