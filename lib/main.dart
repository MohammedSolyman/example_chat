import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theming/theming.dart';
import 'features/auth/presentaion_layer/controller.dart';
import 'features/file/presentaion_layer/controller.dart';
import 'features/group/presentaion_layer/group_controller.dart';
import 'features/message/presentaion_layer/controller.dart';
import 'features/user/presentaion_layer/controller.dart';
import 'firebase_options.dart';
import 'core/dependency_injection/dependency_injection.dart' as di;
import 'pages/sign_in_page/sign_in_page.dart';

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
    Get.put(di.sl<AuthController>());
    Get.put(di.sl<MessageController>());
    Get.put(di.sl<FileController>());
    Get.put(di.sl<UserController>());
    Get.put(di.sl<GroupController>());

    return GetMaterialApp(
      theme: AppTheme.lightThemeData,
      home: const SignInPage(),
    );
  }
}
