// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/constants/app_messages.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/pages_names.dart';
import '../core/theming/theming.dart';
import '../core/widgets/app_icon.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_text.dart';
import '../core/widgets/custom_text_field.dart';
import '../core/widgets/custom_title.dart';
import '../core/widgets/show_snackbar.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryCollor,
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
                  const CustomText(text: AppStrings.login),
                  const SizedBox(height: 15),
                  CustomTextField(
                    hintText: AppStrings.email,
                    controller: emailController,
                    isEmail: true,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: AppStrings.password,
                    controller: passwordController,
                    isEmail: false,
                  ),
                  const SizedBox(height: 20),
                  _logInButton(context),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        text: AppStrings.noAccount,
                        isSamll: true,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(PagesNames.registerPage);
                          },
                          child: const CustomText(
                            text: AppStrings.createAccount,
                            isSamll: true,
                          )),
                    ],
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  CustomButton _logInButton(BuildContext context) {
    return CustomButton(
        text: AppStrings.login,
        myFunc: () async {
          FormState? fs = formKey.currentState;
          if (fs!.validate()) {
            try {
              final credential = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text);
              showMySnackBar(
                  context: context,
                  msg: AppMessages.successLogIn,
                  isSuccess: true);

              String id = credential.user!.uid;

              Navigator.of(context).pushNamedAndRemoveUntil(
                  PagesNames.contactsPage,
                  arguments: {'id': id},
                  (route) => false);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                showMySnackBar(
                    context: context,
                    msg: AppMessages.userNotFound,
                    isSuccess: false);
              } else if (e.code == 'wrong-password') {
                showMySnackBar(
                    context: context,
                    msg: AppMessages.wrongPassword,
                    isSuccess: false);
              } else if (e.code == 'invalid-credential') {
                showMySnackBar(
                    context: context,
                    msg: AppMessages.wrongdata,
                    isSuccess: false);
              }
            }
          }
        });
  }
}
