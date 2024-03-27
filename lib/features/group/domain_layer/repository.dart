import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import 'entity.dart';

abstract class BaseGroupRepository {
  Future<Either<Failure, String>> createGroup(GroupEntity groupEntity);
  Future<Either<Failure, Unit>> updateGroup(GroupEntity groupEntity);
  Future<Either<Failure, Unit>> addUsersGroup(
      List<String> usersIds, String groupId);
  Future<Either<Failure, GroupEntity>> getGroupInfo(String groupId);
  Future<Either<Failure, Unit>> getGroups(
      String currentUserId, void Function(List<GroupEntity>) callback);
}
