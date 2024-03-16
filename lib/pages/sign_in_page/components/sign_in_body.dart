import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/custom_title.dart';
import 'lower_line.dart';
import 'sign_in_button.dart';

class SignInBody extends StatelessWidget {
  SignInBody({super.key});

  final TextEditingController tecEmail = TextEditingController();
  final TextEditingController tecPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                const CustomText(text: AppStrings.login),
                const SizedBox(height: 15),
                CustomTextField(
                  hintText: AppStrings.email,
                  controller: tecEmail,
                  isEmail: true,
                  isPassword: false,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: AppStrings.password,
                  controller: tecPassword,
                  isEmail: false,
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                SignInButton(
                    formKey: formKey,
                    tecEmail: tecEmail,
                    tecPassword: tecPassword),
                const SizedBox(height: 10),
                const LowerLine(),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
