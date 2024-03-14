import 'package:dartz/dartz.dart';
import 'package:my_cli_test/features/user/domain_layer/entity.dart';

import '../../../core/errors/failures.dart';

abstract class BaseUserRepository {
  //authentication
  Future<Either<Failure, String>> signUp(UserEntity userEntity);
  Future<Either<Failure, String>> signIn(UserEntity userEntity);
  Future<Either<Failure, Unit>> signOut(UserEntity userEntity);

  //interactions with (contacts info collection)
  Future<Either<Failure, Unit>> addUserToContactInfo(UserEntity userEntity);
  Future<Either<Failure, Unit>> getUsersFromCantactsInfo(
      String currentUserId, void Function(List<UserEntity>) callback);

  //interactions with groups
  Future<Either<Failure, Unit>> addUsersToGroup(
      List<UserEntity> usersEntities, String groupId);
  Future<Either<Failure, Unit>> deleteUserFromGroup(
      UserEntity userEntity, String groupId);
}
