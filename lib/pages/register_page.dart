// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_cli_test/core/constants/pages_names.dart';
import 'package:my_cli_test/models/user_model.dart';
import '../core/constants/app_messages.dart';
import '../core/constants/app_strings.dart';
import '../core/theming/theming.dart';
import '../core/widgets/app_icon.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_text.dart';
import '../core/widgets/custom_text_field.dart';
import '../core/widgets/custom_title.dart';
import '../core/widgets/show_snackbar.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController nameController = TextEditingController();
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
                  const CustomText(text: AppStrings.register),
                  const SizedBox(height: 15),
                  CustomTextField(
                    hintText: AppStrings.email,
                    controller: emailController,
                    isEmail: true,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: AppStrings.name,
                    controller: nameController,
                    isEmail: false,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: AppStrings.password,
                    controller: passwordController,
                    isEmail: false,
                  ),
                  const SizedBox(height: 20),
                  _registerButton(context),
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

  CustomButton _registerButton(BuildContext context) {
    return CustomButton(
        text: AppStrings.register,
        myFunc: () async {
          //////////////////////////////////////////////////////
          // part 1. registering the user //////////////////////
          // 1.1 prepare information
          String email = emailController.text;
          String name = nameController.text;
          String password = passwordController.text;
          String id = '';
          UserModel user =
              UserModel(name: name, email: email, password: password);

          FormState? fs = formKey.currentState;
          if (fs!.validate()) {
            //1.2 if the user enter a good formatted email, do the following:

            try {
              //1.3 try to register this user to firebase auth
              UserCredential credential = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: user.email, password: user.password!);
              id = credential.user!.uid;

              //1.4 if everything is ok show a snackBar telling the user the registe is successful
              showMySnackBar(
                  context: context,
                  msg: AppMessages.successRegisteration,
                  isSuccess: true);

              //1.5 and clear all text fields
              emailController.clear();
              passwordController.clear();
              nameController.clear();

              // 1.6 in case of known errors occur:
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                // show a snackBar telling the user the error

                showMySnackBar(
                    context: context,
                    msg: AppMessages.weakPassword,
                    isSuccess: false);
              } else if (e.code == 'email-already-in-use') {
                // show a snackBar telling the user the error
                showMySnackBar(
                    context: context,
                    msg: AppMessages.existingAccount,
                    isSuccess: false);
              }
            } catch (e) {
              // in case of unknown error show a snackbar with the error:
              showMySnackBar(
                  context: context, msg: e.toString(), isSuccess: false);
            }
          }

          /////////////////////////////////////////////////////////
          // part 2. add the user info in contacts ////////////////
          if (id != '') {
            // If the registering process was successful, the
            // will get a (id).

            try {
              //2.1 try toadd this user to the (contacts) collection
              //in the firebase and assign the user id as a document name.
              FirebaseFirestore myInstance = FirebaseFirestore.instance;
              CollectionReference<Map<String, dynamic>> colRef =
                  myInstance.collection('contacts');
              DocumentReference<Map<String, dynamic>> docRef = colRef.doc(id);
              docRef.set({'id': id, 'name': user.name, 'email': user.email});

              //2.2 remove all pages and navigate to the contacts page
              Navigator.of(context).pushNamedAndRemoveUntil(
                  PagesNames.contactsPage,
                  arguments: {'id': id},
                  (route) => false);
            } catch (e) {
              print(e.toString());
            }
          }
        });
  }
}
