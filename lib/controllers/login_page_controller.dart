// ignore_for_file: use_build_context_synchronously
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../core/constants/app_messages.dart';
import '../core/widgets/show_snackbar.dart';
import '../models/login_page_model.dart';
import '../core/models/user_model.dart';
import '../pages/contacts_page.dart';
import '../pages/register_page.dart';

class LogInPageController extends GetxController {
  Rx<LogInPageModel> model = LogInPageModel().obs;

  Future<void> logInFunction(BuildContext context) async {
    // 1.1 prepare information
    String email = model.value.emailController.text;
    String password = model.value.passwordController.text;
    UserModel user = UserModel(email: email, password: password);

    FormState? fs = model.value.formKey.currentState;
    if (fs!.validate()) {
      //if the user enter a good formatted email, do the following:

      try {
        //try to sign in this user to firebase auth
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: user.email, password: user.password!);

        //if everything is ok show a snackBar telling the user the logging in is
        //successful
        showMySnackBar(
            context: context, msg: AppMessages.successLogIn, isSuccess: true);

        //geting the id of the user
        user.id = credential.user!.uid;

        //clear all text fields
        _clearTextFields();

        _goToContactPage(id: user.id!);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          // show a snackBar telling the user the error
          showMySnackBar(
              context: context,
              msg: AppMessages.userNotFound,
              isSuccess: false);
        } else if (e.code == 'wrong-password') {
          // show a snackBar telling the user the error
          showMySnackBar(
              context: context,
              msg: AppMessages.wrongPassword,
              isSuccess: false);
        } else if (e.code == 'invalid-credential') {
          // show a snackBar telling the user the error
          showMySnackBar(
              context: context, msg: AppMessages.wrongdata, isSuccess: false);
        }
      }
    }
  }

  void _goToContactPage({required String id}) {
    Get.offAll(() => ContactsPage(currentUserId: id));
  }

  void goToRegisterPage() {
    Get.to(const RegisterPage());
  }

  void _clearTextFields() {
    //clear all text fields
    model.value.emailController.clear();
    model.value.passwordController.clear();
  }
}
