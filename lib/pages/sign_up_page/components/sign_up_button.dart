import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/models/user_model.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../features/auth/presentaion_layer/controller.dart';
import '../../../features/user/presentaion_layer/controller.dart';
import '../../home_page/home_page.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    required this.formKey,
    required this.tecEmail,
    required this.tecName,
    required this.tecPassword,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController tecEmail;
  final TextEditingController tecName;
  final TextEditingController tecPassword;

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    AuthController authController = Get.find<AuthController>();
    return CustomButton(
        text: AppStrings.register,
        myFunc: () async {
          bool isValid = formKey.currentState!.validate();
          if (isValid) {
            // prepare user model
            UserModel userModel = UserModel(
                subscribedGroupsIds: const [],
                email: tecEmail.text,
                name: tecName.text,
                password: tecPassword.text);

            // sign in
            UserModel? userModelWithId =
                await authController.signUpFunction(context, userModel);

            //if siging up is successful
            if (userModelWithId != null) {
              // add this user to contacts info collection
              userController.addUserToContactInfoFunction(
                  context: context, userModel: userModelWithId);

              // navigate to hompage
              Get.offAll(() => HomePage(currentUser: userModelWithId));
            }
          }
        });
  }
}
