import 'package:flutter/material.dart';
import '../routes/route_generator.dart';
import '../theme/app_theme.dart';

class Application extends StatelessWidget {
  Application({super.key});

  ///Initialize [AppTheme] with [seed] color
  final AppTheme _appTheme = AppTheme(seed: const Color(0xFF664BC9));

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: RouteGenerator.router,
      theme: _appTheme.theme,
    );
  }
}
