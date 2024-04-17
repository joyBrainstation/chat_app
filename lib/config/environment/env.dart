import 'package:chat_app/config/environment/environment_types.dart';
import 'package:chat_app/config/service_locator/service_locator.dart';
import 'package:chat_app/core/app/application.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../firebase/firebase_options.dart';

abstract class Env {
  //get current environment types
  EnvType get envType;

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    setupServiceLocator();
  }

  void run() {
    runApp(
      // For widgets to be able to read providers, we need to wrap the entire
      // application in a "ProviderScope" widget.
      // This is where the state of our providers will be stored.
      ProviderScope(
        child: Application(),
      ),
    );
  }
}
