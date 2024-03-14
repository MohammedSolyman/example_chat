import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import 'entity.dart';

abstract class BaseUserRepository {
  //authentication
  Future<Either<Failure, UserEntity>> signUp(UserEntity userEntity);
  Future<Either<Failure, String>> signIn(UserEntity userEntity);
  Future<Either<Failure, Unit>> signOut(UserEntity userEntity);

  //interactions with (contacts info collection)
  Future<Either<Failure, Unit>> addUserToContactInfo(UserEntity userEntity);
  Future<Either<Failure, Unit>> getUsersFromCantactsInfo(
      String currentUserId, void Function(List<UserEntity>) callback);
  Future<Either<Failure, UserEntity>> getUserInfo(String userId);

  //interactions with groups
  Future<Either<Failure, Unit>> addGroupToUser(
      UserEntity userEntity, String groupId);
  Future<Either<Failure, Unit>> deleteGroupFromUser(
      UserEntity userEntity, String groupId);
}
