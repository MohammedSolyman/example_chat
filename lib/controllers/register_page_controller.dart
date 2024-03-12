// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../core/constants/app_messages.dart';
import '../core/widgets/show_snackbar.dart';
import '../models/register_page_model.dart';
import '../core/models/user_model.dart';
import '../pages/contacts_page.dart';

class RegisterController extends GetxController {
  Rx<RegisterPageModel> model = RegisterPageModel().obs;

  _signUp(BuildContext context) async {
    // 1.1 prepare information
    String email = model.value.emailController.text;
    String name = model.value.nameController.text;
    String password = model.value.passwordController.text;
    UserModel user = UserModel(name: name, email: email, password: password);

    FormState? fs = model.value.formKey.currentState;
    if (fs!.validate()) {
      //if the user enter a good formatted email, do the following:
      try {
        //try to register this user to firebase auth
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: user.email, password: user.password!);

        //if everything is ok show a snackBar telling the user the
        //registeration is successful
        showMySnackBar(
            context: context,
            msg: AppMessages.successRegisteration,
            isSuccess: true);

        //geting the id of the user
        user.id = credential.user!.uid;

        //clear all text fields
        _clearTextFields();

        //returning the registered user
        return user;

        //in case of known errors occur:
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
        } else {
          // in case of unknown error show a snackbar with the error:
          showMySnackBar(
              context: context, msg: AppMessages.tryAgain, isSuccess: false);
        }
      }
    }
  }

  registerFunction(BuildContext context) async {
    try {
      //if the registering the user is successful,
      //add this user to the contacts collection in firebase store
      UserModel user = await _signUp(context);
      await _addToContacts(user);
    } catch (e) {
      //in case of error
      print(e.toString());
    }
  }

  Future<void> _addToContacts(UserModel user) async {
    try {
      //try to add this user to the (contacts) collection
      //in the firebase and assign the user id as a document name.
      FirebaseFirestore myInstance = FirebaseFirestore.instance;
      CollectionReference<Map<String, dynamic>> colRef =
          myInstance.collection('contacts info');
      DocumentReference<Map<String, dynamic>> docRef = colRef.doc(user.id);
      await docRef.set({'id': user.id, 'name': user.name, 'email': user.email});

      //remove all pages and navigate to the contacts page
      _goToContactPage(id: user.id!);
    } catch (e) {
      print(e.toString());
    }
  }

  void _goToContactPage({required String id}) {
    Get.offAll(() => ContactsPage(
          currentUserId: id,
        ));
  }

  void _clearTextFields() {
    //clear all text fields
    model.value.emailController.clear();
    model.value.passwordController.clear();
    model.value.nameController.clear();
  }
}
