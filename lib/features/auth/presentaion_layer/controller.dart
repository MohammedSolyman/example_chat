import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/entities/user_entitie.dart';
import '../../../core/errors/failures.dart';
import '../../../core/models/user_model.dart';
import '../../../core/widgets/show_my_dialoge.dart';
import '../domain_layer/use_cases.dart';

// class CustomUser {
//   UserModel user;
//   bool isSelected;
//   CustomUser({
//     required this.user,
//     required this.isSelected,
//   });
// }

// class UserControllerModel {
//   List<UserModel>? users;
//   List<CustomUser> customUsers = [];
//   String currentUserId = '';
//   UserModel? currentUser;
// }

class AuthController extends GetxController {
//  Rx<UserControllerModel> model = UserControllerModel().obs;

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

  signUpFunction(BuildContext context, UserModel userModel) async {
    Either<Failure, UserEntity> result = await signUpUseCase.signUp(userModel);

    return result.fold((Failure failure) {
      showMyDialog(
          context: context, msg: failure.failureMessage, isSuccess: false);
    }, (UserEntity user) async {
      UserModel userModel = UserModel.fromEntity(user);
      return userModel;
    });
  }

  signInFunction(BuildContext context, UserModel userModel) async {
    Either<Failure, String> result = await signInUseCase.signIn(userModel);

    return result.fold((Failure failure) {
      showMyDialog(
          context: context, msg: failure.failureMessage, isSuccess: false);
    }, (String userId) {
      return userId;
    });
  }

  getUserInfoFunction(String userId) async {
    Either<Failure, UserEntity> result = await getUserInfo.getUserInfo(userId);

    return result.fold((Failure failure) {
      print(' --error -------');
    }, (UserEntity userEntity) {
      UserModel user = UserModel.fromEntity(userEntity);
      return user;
    });
  }

  // Future<void> toSignUpPage() async {
  //   // navigate to register page
  //   await Get.to(() => const RegisterPage());
  // }

  // Future<void> _toHomePage(UserModel currentUser) async {
  //   // remove all page from the route and navigate to contacts page
  //   await Get.offAll(() => HomePage(currentUser: currentUser));
  // }

  // String generateRoomId(String recieverUserId) {
  //   // this function generate an ID to this chat room, by combining the ID's
  //   //of the two users after sorting them
  //   List<String> idsCombination = [model.value.currentUserId, recieverUserId];
  //   idsCombination.sort(
  //     (a, b) => a.compareTo(b),
  //   );
  //   return 'contactsrooms${idsCombination[0]}-${idsCombination[1]}';
  // }

  // Future<void> toSignUpPage() async {
  //   // navigate to register page
  //   await Get.to(() => const RegisterPage());
  // }

  // Future<void> _toHomePage(UserModel currentUser) async {
  //   // remove all page from the route and navigate to contacts page
  //   await Get.offAll(() => HomePage(currentUser: currentUser));
  // }
}
