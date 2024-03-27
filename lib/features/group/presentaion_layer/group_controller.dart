import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/errors/failures.dart';
import '../../../core/widgets/show_my_dialoge.dart';
import '../data_layer/model.dart';
import '../domain_layer/entity.dart';
import '../domain_layer/use_cases.dart';

class StateModel {
  String groupId = '';
  List<GroupModel> allGroups = [];
  GroupModel? currentGroup; //selected group to be shown in the chat room
}

class GroupController extends GetxController {
  Rx<StateModel> model = StateModel().obs;
  CreateGroupUseCase createGroupUseCase;
  UpdateGroupUseCase updateGroupUseCase;
  AddUsersGroupUseCase addUsersGroupUseCase;
  GetGroupsUseCase getAllGroupsUseCase;
  GetGroupInfoUseCase getGroupInfoUseCase;
  GroupController(
      {required this.createGroupUseCase,
      required this.updateGroupUseCase,
      required this.getGroupInfoUseCase,
      required this.addUsersGroupUseCase,
      required this.getAllGroupsUseCase});

  void assignCurrentGroup(GroupModel currentGroup) {
    model.update((val) {
      val!.currentGroup = currentGroup;
    });
  }

  Future<GroupModel?> getGroupInfoFunction(String groupId) async {
    Either<Failure, GroupEntity> result =
        await getGroupInfoUseCase.getGroupInfo(groupId);

    return result.fold((Failure failure) {
      // showMyDialog(
      //     context: context, msg: failure.failureMessage, isSuccess: false);
    }, (GroupEntity groupEntity) {
      return GroupModel.fromEntity(groupEntity);
    });
  }

  Future<void> updateGoup({
    required BuildContext context,
    required GroupModel groupModel,
  }) async {
    Either<Failure, Unit> result =
        await updateGroupUseCase.updateGroup(groupModel);

    result.fold((Failure failure) {
      showMyDialog(
          context: context, msg: failure.failureMessage, isSuccess: false);
    }, (Unit unit) {});
  }

  createGoup(
      {required BuildContext context,
      required String groupName,
      required String groupDescription,
      required adminId}) async {
    // this function create a group and assign the creating user as an admin

    DateTime now = DateTime.now();
    int dateTime = now.millisecondsSinceEpoch;

    GroupModel groupEntity = GroupModel(
        creationDateTime: dateTime,
        adminId: adminId,
        groupName: groupName,
        groupDescription: groupDescription,
        groupImage: '',
        members: [adminId]);
    Either<Failure, String> result =
        await createGroupUseCase.createGroup(groupEntity);

    result.fold((Failure failure) {
      showMyDialog(
          context: context, msg: failure.failureMessage, isSuccess: false);
    }, (String groupId) {
      model.update((val) {
        val!.groupId = groupId;
      });
    });
  }

  addUsersToGroupFunction(List<String> usersIds, String groupId) async {
    await addUsersGroupUseCase.addUsersGroupUseCase(usersIds, groupId);
  }

  getGroupsFunction({required String currentUserId}) async {
    await getAllGroupsUseCase.getGroupsUseCase(currentUserId, (p0) {
      List<GroupModel> groups =
          p0.map((e) => GroupModel.fromEntity(e)).toList();
      model.update((val) {
        val!.allGroups = groups;
      });
    });
  }
}
