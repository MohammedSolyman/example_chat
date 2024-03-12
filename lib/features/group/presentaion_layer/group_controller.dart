// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cli_test/features/group/domain_layer/entity.dart';

import '../../../core/errors/failures.dart';
import '../../../core/widgets/show_my_dialoge.dart';
import '../domain_layer/use_cases.dart';

class GroupController extends GetxController {
  CreateGroupUseCase createGroupUseCase;
  RenameGroupUseCase renameGroupUseCase;
  GroupController({
    required this.createGroupUseCase,
    required this.renameGroupUseCase,
  });

  renameGoup(BuildContext context, String groupName) async {
    GroupEntity groupEntity = GroupEntity(groupName: groupName);
    Either<Failure, Unit> result =
        await renameGroupUseCase.renameGroup(groupEntity);

    result.fold((Failure failure) {
      showMyDialog(
          context: context, msg: failure.failureMessage, isSuccess: false);
    }, (Unit unit) {});
  }

  createGoup(
      {required BuildContext context,
      required String groupName,
      required adminId}) async {
    GroupEntity groupEntity =
        GroupEntity(groupName: groupName, members: [adminId]);
    Either<Failure, String> result =
        await createGroupUseCase.createGroup(groupEntity);

    result.fold((Failure failure) {
      showMyDialog(
          context: context, msg: failure.failureMessage, isSuccess: false);
    }, (String groupId) {
      print('------------------------------');
      print(groupId);
    });
  }
}
