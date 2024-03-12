import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cli_test/core/errors/failures.dart';
import 'package:my_cli_test/features/user/data_layer/model.dart';
import 'package:my_cli_test/features/user/domain_layer/entity.dart';

import 'package:my_cli_test/features/user/domain_layer/use_cases.dart';
import 'package:my_cli_test/pages/register_page.dart';

import '../../../core/widgets/show_my_dialoge.dart';
import '../../../pages/contacts_page.dart';

class UserController extends GetxController {
  SignUpUseCase signUpUseCase;
  SignInUseCase signInUseCase;
  SignOutUseCase signOutUseCase;

  AddUserToContactInfoUseCase addUserToContactInfoUseCase;
  GetUsersFromCantactsInfoUseCase getUsersFromCantactsInfoUseCase;

  AddUsersToGroup addUsersToGroup;
  DeleteUserFromGroup deleteUserFromGroup;

  UserController({
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.signOutUseCase,
    required this.addUserToContactInfoUseCase,
    required this.getUsersFromCantactsInfoUseCase,
    required this.addUsersToGroup,
    required this.deleteUserFromGroup,
  });

  signUp(BuildContext context, UserModel userModel) async {
    Either<Failure, String> result = await signUpUseCase.signUp(userModel);

    result.fold((Failure failure) {
      showMyDialog(
          context: context, msg: failure.failureMessage, isSuccess: false);
    }, (String userId) async {
      await addUserToContactInfo(context, userModel.copyWith(id: userId));
      _toContactsPage(userId);
    });
  }

  signIn(BuildContext context, UserModel userModel) async {
    Either<Failure, String> result = await signInUseCase.signIn(userModel);

    result.fold((Failure failure) {
      showMyDialog(
          context: context, msg: failure.failureMessage, isSuccess: false);
    }, (String userId) {
      _toContactsPage(userId);
    });
  }

  addUserToContactInfo(BuildContext context, UserModel userModel) async {
    Either<Failure, Unit> result =
        await addUserToContactInfoUseCase.addUserToContactInfo(userModel);

    result.fold((Failure failure) {
      showMyDialog(
          context: context, msg: failure.failureMessage, isSuccess: false);
    }, (Unit unit) {});
  }

  getUsersFromCantactsInfo(BuildContext context, String currentUserId) async {
    Either<Failure, List<UserEntity>> result =
        await getUsersFromCantactsInfoUseCase
            .getUsersFromCantactsInfo(currentUserId);

    result.fold((Failure failure) {
      showMyDialog(
          context: context, msg: failure.failureMessage, isSuccess: false);
    }, (List<UserEntity> users) {});
  }

  Future<void> toSignUpPage() async {
    // navigate to register page
    await Get.to(() => const RegisterPage());
  }

  Future<void> _toContactsPage(String currentUserId) async {
    // remove all page from the route and navigate to contacts page
    await Get.offAll(() => ContactsPage(currentUserId: currentUserId));
  }
}
