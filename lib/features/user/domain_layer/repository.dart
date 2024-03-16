import 'package:dartz/dartz.dart';
import '../../../core/entities/user_entitie.dart';
import '../../../core/errors/failures.dart';

abstract class BaseUserRepository {
  //interactions with (contacts info collection)
  Future<Either<Failure, Unit>> addUserToContactInfo(UserEntity userEntity);
  Future<Either<Failure, Unit>> getUsersFromCantactsInfo(
      String userId, void Function(List<UserEntity>) callback);

  //interactions with groups
  Future<Either<Failure, Unit>> addGroupToUser(
      UserEntity userEntity, String groupId);
  Future<Either<Failure, Unit>> deleteGroupFromUser(
      UserEntity userEntity, String groupId);
}
