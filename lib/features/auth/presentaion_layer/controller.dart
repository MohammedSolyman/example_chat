import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/entities/user_entitie.dart';
import '../../../core/errors/failures.dart';
import '../../../core/models/user_model.dart';
import '../../../core/widgets/show_my_dialoge.dart';
import '../domain_layer/use_cases.dart';

class AuthModel {
  UserModel? currentUser;
}

class AuthController extends GetxController {
  Rx<AuthModel> model = AuthModel().obs;

  SignUpUseCase signUpUseCase;
  SignInUseCase signInUseCase;
  SignOutUseCase signOutUseCase;
  GetUserInfo getUserInfo;

  AuthController({
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.signOutUseCase,
    required this.getUserInfo,
  });

  void assignCurrentUser(UserModel currentUser) {
    model.update((val) {
      val!.currentUser = currentUser;
    });
    print(model.value.currentUser!.name);
    print(model.value.currentUser!.email);
    print(model.value.currentUser!.password);
  }

  Future<UserModel?> signUpFunction(
      BuildContext context, UserModel userModel) async {
    Either<Failure, UserEntity> result = await signUpUseCase.signUp(userModel);

    return result.fold((Failure failure) {
      showMyDialog(
          context: context, msg: failure.failureMessage, isSuccess: false);
    }, (UserEntity user) async {
      UserModel userModel = UserModel.fromEntity(user);
      return userModel;
    });
  }

  Future<String?> signInFunction(
      BuildContext context, UserModel userModel) async {
    Either<Failure, String> result = await signInUseCase.signIn(userModel);

    return result.fold((Failure failure) {
      showMyDialog(
          context: context, msg: failure.failureMessage, isSuccess: false);
    }, (String userId) {
      return userId;
    });
  }

  Future<void> signOutFunction(BuildContext context) async {
    Either<Failure, Unit> result = await signOutUseCase.signOut();

    return result.fold((Failure failure) {
      showMyDialog(
          context: context, msg: failure.failureMessage, isSuccess: false);
    }, (Unit unit) {});
  }

  Future<UserModel?> getUserInfoFunction(String userId) async {
    Either<Failure, UserEntity> result = await getUserInfo.getUserInfo(userId);

    return result.fold((Failure failure) {}, (UserEntity userEntity) {
      UserModel user = UserModel.fromEntity(userEntity);
      return user;
    });
  }
}
