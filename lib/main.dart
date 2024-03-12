import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cli_test/core/theming/theming.dart';
import 'package:my_cli_test/firebase_options.dart';
import 'package:my_cli_test/pages/login_page.dart';
import 'package:my_cli_test/core/dependency_injection/dependency_injection.dart'
    as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.lightThemeData,
      home: const LoginPage(),
    );
  }
}
