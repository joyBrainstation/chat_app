import 'package:chat_app/features/authentication/application/button_position_provider.dart';
import 'package:chat_app/features/authentication/application/sign_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});
  static const String path = "loginScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxWidth = MediaQuery.of(context).size.width * 0.9;
    double posX = ref.watch(buttonPositionProvider);
    SignInProvider signInProvider = ref.read(signinProvider(context));
    return Scaffold(
      body: Center(
        child: Container(
          color: Theme.of(context).primaryColor,
          width: maxWidth * 0.9,
          height: 50,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildGetStartedLabel(context),
              _buildArrowWidget(posX),
              _buildSigninWithGoogleButton(context, posX, signInProvider),
              GestureDetector(
                onPanUpdate: (details) {
                  ref.read(buttonPositionProvider.notifier).state =
                      details.localPosition.dx;
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  TextStyle? _headerTextStyle(BuildContext context) => Theme.of(context)
      .primaryTextTheme
      .bodyLarge
      ?.copyWith(fontWeight: FontWeight.bold);

  Widget _buildGetStartedLabel(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        "Get Started",
        style: _headerTextStyle(context),
      ),
    );
  }

  Widget _buildArrowWidget(double posX) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 100),
      left: posX,
      key: const ValueKey("item 1"),
      child: Container(
        height: 50.0,
        width: 50.0,
        color: Colors.white,
        alignment: Alignment.center,
        child: const Icon(
          Icons.arrow_forward,
        ),
      ),
    );
  }

  Widget _buildSigninWithGoogleButton(BuildContext context, double posX, SignInProvider signInProvider) {
    return Positioned(
        left: 0,
        width: posX,
        child: Container(
          color: Theme.of(context).primaryColorDark,
          height: 50,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
             signInProvider.authenticate();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Center(
                  child: Text(
                'Sign in with Google',
                style: _headerTextStyle(context),
                overflow: TextOverflow.ellipsis,
              )),
            ),
          ),
        ));
  }
}
