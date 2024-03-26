import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../features/auth/presentaion_layer/controller.dart';
import '../../../sign_in_page/sign_in_page.dart';

class SignOutTile extends StatelessWidget {
  const SignOutTile({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();

    return ListTile(
      leading: const Icon(Icons.exit_to_app),
      title: const CustomText(text: AppStrings.signOut),
      onTap: () async {
        //sign out the current user.
        await authController.signOutFunction(context);

        //remove all previous routes and navigate to sign in page.
        Get.offAll(() => const SignInPage());
      },
    );
  }
}
