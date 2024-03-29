import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/assets_paths.dart';
import '../core/widgets/app_icon.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_text.dart';
import '../core/widgets/custom_text_field.dart';
import '../core/widgets/custom_title.dart';
import '../core/dependency_injection/dependency_injection.dart' as di;
import '../features/user/data_layer/model.dart';
import '../features/user/presentaion_layer/controller.dart';
import 'home_page/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(di.sl<UserController>());

    TextEditingController tecEmail = TextEditingController();
    TextEditingController tecPassword = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AssetsPaths.background01),
                fit: BoxFit.cover)),
        child: Padding(
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
                    CustomButton(
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
                            await userController.signInFunction(
                                context, userModel);

                            //get this user id
                            String userId =
                                userController.model.value.currentUserId;

                            //get this user info
                            await userController.getUserInfoFunction(userId);

                            //get this user model
                            UserModel currentUser =
                                userController.model.value.currentUser!;

                            //go to homepage
                            Get.off(() => HomePage(currentUser: currentUser));
                          }
                        }),
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
                              userController.toSignUpPage();
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
      ),
    );
  }
}
