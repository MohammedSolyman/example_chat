import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/errors/failures.dart';
import '../../../core/widgets/show_my_dialoge.dart';
import '../../../pages/contacts_page.dart';
import '../../../pages/register_page.dart';
import '../data_layer/data_source.dart';
import '../data_layer/model.dart';
import '../domain_layer/use_cases.dart';

class UserControllerModel {
  List<UserModel>? users;
  String currentUserId = '';
}

class UserController extends GetxController {
  Rx<UserControllerModel> model = UserControllerModel().obs;
  RemoteUserDataSource remoteUserDataSource = RemoteUserDataSource();

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

  getUsersFromCantactsInfo(BuildContext context) async {
    await getUsersFromCantactsInfoUseCase.getUsersFromCantactsInfo(
      model.value.currentUserId,
      (p0) {
        List<UserModel> usersModels =
            p0.map((e) => UserModel.fromEntity(e)).toList();
        model.update((val) {
          val!.users = usersModels;
        });
      },
    );
  }

  Future<void> toSignUpPage() async {
    // navigate to register page
    await Get.to(() => const RegisterPage());
  }

  Future<void> _toContactsPage(String currentUserId) async {
    // remove all page from the route and navigate to contacts page
    await Get.offAll(() => ContactsPage(currentUserId: currentUserId));
  }

  void getContactsPageInfo(String id) {
    //this function fetches this user id
    model.update((val) {
      val!.currentUserId = id;
    });
  }

  String generateRoomId(String recieverUserId) {
    // this function generate an ID to this chat room, by combining the ID's
    //of the two users after sorting them
    List<String> idsCombination = [model.value.currentUserId, recieverUserId];
    idsCombination.sort(
      (a, b) => a.compareTo(b),
    );
    return 'contactsrooms${idsCombination[0]}-${idsCombination[1]}';
  }
}
