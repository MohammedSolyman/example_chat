// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/errors/failures.dart';
import '../../../core/widgets/show_my_dialoge.dart';
import '../data_layer/model.dart';
import '../domain_layer/use_cases.dart';

class StateModel {
  String groupId = '';
  List<GroupModel> allGroups = [];
}

class GroupController extends GetxController {
  Rx<StateModel> model = StateModel().obs;
  CreateGroupUseCase createGroupUseCase;
  UpdateGroupUseCase updateGroupUseCase;
  AddUsersGroupUseCase addUsersGroupUseCase;
  GetAllGroupsUseCase getAllGroupsUseCase;
  GroupController(
      {required this.createGroupUseCase,
      required this.updateGroupUseCase,
      required this.addUsersGroupUseCase,
      required this.getAllGroupsUseCase});

  updateGoup({
    required BuildContext context,
    required GroupModel groupModel,
  }) async {
    groupModel.groupName = 'new name';
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
    GroupModel groupEntity = GroupModel(
        groupName: groupName,
        groupDescription: groupDescription,
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

  getAllGroupsFunction() async {
    await getAllGroupsUseCase.getAllGroupsUseCase((p0) {
      List<GroupModel> groups =
          p0.map((e) => GroupModel.fromEntity(e)).toList();
      model.update((val) {
        val!.allGroups = groups;
      });
    });
  }
}
