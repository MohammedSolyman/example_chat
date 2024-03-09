import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_cli_test/firebase_options.dart';
import 'core/constants/pages_names.dart';
import 'core/routing/routing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: PagesNames.logInPage,
      routes: myRoutes,
    );
  }
}
