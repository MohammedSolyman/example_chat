import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/entities/user_entitie.dart';
import '../../../core/errors/failures.dart';
import '../../../core/models/user_model.dart';
import '../../../core/widgets/show_my_dialoge.dart';
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
  // String currentUserId = '';
  // UserModel? currentUser;
}

class UserController extends GetxController {
  Rx<UserControllerModel> model = UserControllerModel().obs;

  AddUserToContactInfoUseCase addUserToContactInfoUseCase;
  GetUsersFromCantactsInfoUseCase getUsersFromCantactsInfoUseCase;
  AddGroupToUser addGroupToUser;
  DeleteGroupFromUser deleteGroupFromUser;
  UpdateContactInfoUseCase updateContactInfoUseCase;

  UserController(
      {required this.addUserToContactInfoUseCase,
      required this.getUsersFromCantactsInfoUseCase,
      required this.addGroupToUser,
      required this.deleteGroupFromUser,
      required this.updateContactInfoUseCase});

  addUserToContactInfoFunction(
      {required BuildContext context, required UserModel userModel}) async {
    Either<Failure, Unit> result =
        await addUserToContactInfoUseCase.addUserToContactInfo(userModel);

    result.fold((Failure failure) {
      showMyDialog(
          context: context, msg: failure.failureMessage, isSuccess: false);
    }, (Unit unit) {});
  }

  getUsersGenerateCustomUsers({required String currentUserId}) async {
    await getUsersFromCantactsInfoUseCase.getUsersFromCantactsInfo(
      currentUserId,
      (List<UserEntity> p0) {
        List<UserModel> usersModels =
            p0.map((e) => UserModel.fromEntity(e)).toList();

        List<CustomUser> customUsers = usersModels
            .map((e) => CustomUser(user: e, isSelected: false))
            .toList();

        model.update((val) {
          val!.users = usersModels;
          val.customUsers = customUsers;
        });
      },
    );
  }

  String generateRoomId(
      {required String recieverId, required String senderId}) {
    // this function generate an ID to this chat room, by combining the ID's
    //of the two users after sorting them
    List<String> idsCombination = [senderId, recieverId];
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

    //Either<Failure, Unit> result =
    await addGroupToUser.addGroupToUser(newUser, groupId);
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

  void makeAll(bool trueOrFalse) {
    model.update((val) {
      val!.customUsers = val.customUsers.map((e) {
        e.isSelected = trueOrFalse;
        return e;
      }).toList();
    });
  }

  Future<void> updateUserFunction(UserModel user) async {
    UserEntity userEntity = user.toEntity();
    // Either<Failure, Unit> result =
    await updateContactInfoUseCase.updateContactInfoUseCase(userEntity);
  }
}
