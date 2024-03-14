import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/errors/failures.dart';
import '../../../core/widgets/show_my_dialoge.dart';
import '../../../pages/home_page/home_page.dart';
import '../../../pages/register_page.dart';
import '../data_layer/data_source.dart';
import '../data_layer/model.dart';
import '../domain_layer/entity.dart';
import '../domain_layer/use_cases.dart';

class CustomUser {
  UserModel user;
  bool isSelected;
  CustomUser({
    required this.user,
    required this.isSelected,
  });
}

class UserControllerModel {
  List<UserModel>? users;
  List<CustomUser> customUsers = [];
  String currentUserId = '';
  UserModel? currentUser;
}

class UserController extends GetxController {
  Rx<UserControllerModel> model = UserControllerModel().obs;
  RemoteUserDataSource remoteUserDataSource = RemoteUserDataSource();

  SignUpUseCase signUpUseCase;
  SignInUseCase signInUseCase;
  SignOutUseCase signOutUseCase;

  AddUserToContactInfoUseCase addUserToContactInfoUseCase;
  GetUsersFromCantactsInfoUseCase getUsersFromCantactsInfoUseCase;
  GetUserInfo getUserInfo;

  AddGroupToUser addGroupToUser;
  DeleteGroupFromUser deleteGroupFromUser;

  UserController({
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.signOutUseCase,
    required this.addUserToContactInfoUseCase,
    required this.getUsersFromCantactsInfoUseCase,
    required this.addGroupToUser,
    required this.deleteGroupFromUser,
    required this.getUserInfo,
  });

  signUp(BuildContext context, UserModel userModel) async {
    Either<Failure, UserEntity> result = await signUpUseCase.signUp(userModel);

    result.fold((Failure failure) {
      showMyDialog(
          context: context, msg: failure.failureMessage, isSuccess: false);
    }, (UserEntity user) async {
      UserModel userModel = UserModel.fromEntity(user);
      await addUserToContactInfo(context, userModel);
      model.update((val) {
        val!.currentUser = userModel;
      });

      _toHomePage(userModel);
    });
  }

  signInFunction(BuildContext context, UserModel userModel) async {
    Either<Failure, String> result = await signInUseCase.signIn(userModel);

    result.fold((Failure failure) {
      showMyDialog(
          context: context, msg: failure.failureMessage, isSuccess: false);
    }, (String userId) {
      model.update((val) {
        val!.currentUserId = userId;
      });
    });
  }

  getUserInfoFunction(String userId) async {
    Either<Failure, UserEntity> result = await getUserInfo.getUserInfo(userId);

    result.fold((Failure failure) => null, (UserEntity userEntity) {
      UserModel user = UserModel.fromEntity(userEntity);
      model.update((val) {
        val!.currentUser = user;
      });
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
        _generateCustomUsers();
      },
    );
  }

  Future<void> toSignUpPage() async {
    // navigate to register page
    await Get.to(() => const RegisterPage());
  }

  Future<void> _toHomePage(UserModel currentUser) async {
    // remove all page from the route and navigate to contacts page
    await Get.offAll(() => HomePage(currentUser: currentUser));
  }

  // void getHomePageInfo(String id) {
  //   //this function fetches this user id
  //   model.update((val) {
  //     val!.currentUserId = id;
  //   });
  // }

  String generateRoomId(String recieverUserId) {
    // this function generate an ID to this chat room, by combining the ID's
    //of the two users after sorting them
    List<String> idsCombination = [model.value.currentUserId, recieverUserId];
    idsCombination.sort(
      (a, b) => a.compareTo(b),
    );
    return 'contactsrooms${idsCombination[0]}-${idsCombination[1]}';
  }

  addGroupToUserFunction({required UserModel user, required groupId}) async {
    List<String> x = user.subscribedGroupsIds;
    List<String> goupsIdList = x.map((e) => e.toString()).toList();
    goupsIdList.add(groupId);

    UserModel newUser = user.copyWith(subscribedGroupsIds: goupsIdList);

    Either<Failure, Unit> result =
        await addGroupToUser.addGroupToUser(newUser, groupId);
  }

  void _generateCustomUsers() {
    List<CustomUser> customUsers = model.value.users!
        .map((e) => CustomUser(user: e, isSelected: false))
        .toList();

    model.update((val) {
      val!.customUsers = customUsers;
    });
  }

  void toggleSelectivity(int index) {
    model.update((val) {
      val!.customUsers[index].isSelected = !val.customUsers[index].isSelected;
    });
  }

  List<String> getSelectedIds() {
    List<String> selectedIds = [];

    for (var element in model.value.customUsers) {
      if (element.isSelected) {
        selectedIds.add(element.user.id!);
      }
    }
    return selectedIds;
  }
}
