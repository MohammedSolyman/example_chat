import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import 'entity.dart';
import 'repository.dart';

class SignUpUseCase {
  BaseUserRepository baseUserRepository;
  SignUpUseCase({required this.baseUserRepository});

  Future<Either<Failure, UserEntity>> signUp(UserEntity userEntity) async {
    return await baseUserRepository.signUp(userEntity);
  }
}

class SignInUseCase {
  BaseUserRepository baseUserRepository;
  SignInUseCase({required this.baseUserRepository});

  Future<Either<Failure, String>> signIn(UserEntity userEntity) async {
    return await baseUserRepository.signIn(userEntity);
  }

  Future<Either<Failure, UserEntity>> signUp(UserEntity userEntity) async {
    return await baseUserRepository.signUp(userEntity);
  }
}

class SignOutUseCase {
  BaseUserRepository baseUserRepository;
  SignOutUseCase({required this.baseUserRepository});

  Future<Either<Failure, Unit>> signOut(UserEntity userEntity) async {
    return await baseUserRepository.signOut(userEntity);
  }
}

class GetUsersFromCantactsInfoUseCase {
  BaseUserRepository baseUserRepository;
  GetUsersFromCantactsInfoUseCase({required this.baseUserRepository});

  Future<Either<Failure, Unit>> getUsersFromCantactsInfo(
      String currentUserId, void Function(List<UserEntity>) callback) async {
    return await baseUserRepository.getUsersFromCantactsInfo(
        currentUserId, callback);
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

class GetUserInfo {
  BaseUserRepository baseUserRepository;
  GetUserInfo({required this.baseUserRepository});

  Future<Either<Failure, UserEntity>> getUserInfo(String userId) async {
    return await baseUserRepository.getUserInfo(userId);
  }
}
