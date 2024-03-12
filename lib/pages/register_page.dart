// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:my_cli_test/features/user/data_layer/model.dart';
import 'package:my_cli_test/features/user/presentaion_layer/controller.dart';
import '../core/constants/app_strings.dart';
import '../core/widgets/app_icon.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_text.dart';
import '../core/widgets/custom_text_field.dart';
import '../core/widgets/custom_title.dart';
import 'package:my_cli_test/core/dependency_injection/dependency_injection.dart'
    as di;

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    //  RegisterController controller = Get.put(RegisterController());
    UserController userController = di.sl<UserController>();

    TextEditingController tecEmail = TextEditingController();
    TextEditingController tecPassword = TextEditingController();
    TextEditingController tecName = TextEditingController();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Spacer(flex: 1),
                  const AppIcon(),
                  const CustomTitle(text: AppStrings.scholarChat),
                  const Spacer(flex: 2),
                  const CustomText(text: AppStrings.register),
                  const SizedBox(height: 15),
                  CustomTextField(
                    hintText: AppStrings.email,
                    controller: tecEmail,
                    isEmail: true,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: AppStrings.name,
                    controller: tecName,
                    isEmail: false,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: AppStrings.password,
                    controller: tecPassword,
                    isEmail: false,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                      text: AppStrings.register,
                      myFunc: () async {
                        bool isValid = formKey.currentState!.validate();
                        if (isValid) {
                          UserModel userModel = UserModel(
                              subscribedGroupsIds: const [],
                              email: tecEmail.text,
                              name: tecName.text,
                              password: tecPassword.text);

                          await userController.signUp(context, userModel);
                        }
                      }),
                  const SizedBox(height: 10),
                  const Spacer(flex: 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
