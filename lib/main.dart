import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theming/theming.dart';
import 'features/user/presentaion_layer/controller.dart';
import 'firebase_options.dart';
import 'core/dependency_injection/dependency_injection.dart' as di;
import 'pages/login_page.dart';

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
    Get.put(di.sl<UserController>());

    return GetMaterialApp(
      theme: AppTheme.lightThemeData,
      home: const LoginPage(),
    );
  }
}
