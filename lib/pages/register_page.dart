// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';
import '../core/constants/app_strings.dart';
import '../core/widgets/app_icon.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_text.dart';
import '../core/widgets/custom_text_field.dart';
import '../core/widgets/custom_title.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterController controller = Get.put(RegisterController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: controller.model.value.formKey,
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
                    controller: controller.model.value.emailController,
                    isEmail: true,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: AppStrings.name,
                    controller: controller.model.value.nameController,
                    isEmail: false,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: AppStrings.password,
                    controller: controller.model.value.passwordController,
                    isEmail: false,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                      text: AppStrings.register,
                      myFunc: () async {
                        controller.registerFunction(context);
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
