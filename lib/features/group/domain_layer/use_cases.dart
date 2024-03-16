import 'package:dartz/dartz.dart';
import 'entity.dart';
import 'repository.dart';
import '../../../core/errors/failures.dart';

class CreateGroupUseCase {
  BaseGroupRepository baseGroupRepository;
  CreateGroupUseCase({required this.baseGroupRepository});

  Future<Either<Failure, String>> createGroup(GroupEntity groupEntity) async {
    return await baseGroupRepository.createGroup(groupEntity);
  }
}

class UpdateGroupUseCase {
  BaseGroupRepository baseGroupRepository;
  UpdateGroupUseCase({required this.baseGroupRepository});

  Future<Either<Failure, Unit>> updateGroup(GroupEntity groupEntity) async {
    return await baseGroupRepository.updateGroup(groupEntity);
  }
}

class AddUsersGroupUseCase {
  BaseGroupRepository baseGroupRepository;
  AddUsersGroupUseCase({required this.baseGroupRepository});

  Future<Either<Failure, Unit>> addUsersGroupUseCase(
      List<String> usersIds, String groupId) async {
    return await baseGroupRepository.addUsersGroup(usersIds, groupId);
  }
}

class GetGroupsUseCase {
  BaseGroupRepository baseGroupRepository;
  GetGroupsUseCase({required this.baseGroupRepository});

  Future<Either<Failure, Unit>> getGroupsUseCase(
      String currentUserId, void Function(List<GroupEntity>) callback) async {
    return await baseGroupRepository.getGroups(currentUserId, callback);
  }
}
