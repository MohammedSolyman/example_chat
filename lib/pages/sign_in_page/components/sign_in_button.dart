import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/models/user_model.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../features/auth/presentaion_layer/controller.dart';
import '../../home_page/home_page.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.formKey,
    required this.tecEmail,
    required this.tecPassword,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController tecEmail;
  final TextEditingController tecPassword;

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();

    return CustomButton(
        text: AppStrings.login,
        myFunc: () async {
          bool isValid = formKey.currentState!.validate();
          if (isValid) {
            //prepare userModel
            UserModel userModel = UserModel(
                subscribedGroupsIds: const [],
                email: tecEmail.text,
                password: tecPassword.text);

            //sign in this user
            String? userId =
                await authController.signInFunction(context, userModel);

            // if the signing in is successful
            if (userId != null) {
              //get this user info
              UserModel? userModelWithInfo =
                  await authController.getUserInfoFunction(userId);

              if (userModelWithInfo != null) {
                //asign this user to the current user
                authController.assignCurrentUser(userModelWithInfo);

                //go to homepage
                Get.offAll(() => const HomePage());
              }
            }
          }
        });
  }
}
