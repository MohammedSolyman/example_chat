import 'package:dartz/dartz.dart';

import '../../../core/entities/user_entitie.dart';
import '../../../core/errors/failures.dart';
import 'repository.dart';

class GetUsersFromCantactsInfoUseCase {
  BaseUserRepository baseUserRepository;
  GetUsersFromCantactsInfoUseCase({required this.baseUserRepository});

  Future<Either<Failure, Unit>> getUsersFromCantactsInfo(
      void Function(List<UserEntity>) callback) async {
    return await baseUserRepository.getUsersFromCantactsInfo(callback);
  }
}

class AddUserToContactInfoUseCase {
  BaseUserRepository baseUserRepository;
  AddUserToContactInfoUseCase({required this.baseUserRepository});

  Future<Either<Failure, Unit>> addUserToContactInfo(
      UserEntity userEntity) async {
    return await baseUserRepository.addUserToContactInfo(userEntity);
  }
}

class DeleteGroupFromUser {
  BaseUserRepository baseUserRepository;
  DeleteGroupFromUser({required this.baseUserRepository});

  Future<Either<Failure, Unit>> deleteGroupFromUser(
      UserEntity userEntity, String groupId) async {
    return await baseUserRepository.deleteGroupFromUser(userEntity, groupId);
  }
}

class AddGroupToUser {
  BaseUserRepository baseUserRepository;
  AddGroupToUser({required this.baseUserRepository});

  Future<Either<Failure, Unit>> addGroupToUser(
      UserEntity usersEntities, String groupId) async {
    return await baseUserRepository.addGroupToUser(usersEntities, groupId);
  }
}
