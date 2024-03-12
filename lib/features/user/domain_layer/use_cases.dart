import 'package:dartz/dartz.dart';
import 'package:my_cli_test/features/user/domain_layer/entity.dart';
import 'package:my_cli_test/features/user/domain_layer/repository.dart';

import '../../../core/errors/failures.dart';

class SignUpUseCase {
  BaseUserRepository baseUserRepository;
  SignUpUseCase({required this.baseUserRepository});

  Future<Either<Failure, String>> signUp(UserEntity userEntity) async {
    return await baseUserRepository.signUp(userEntity);
  }
}

class SignInUseCase {
  BaseUserRepository baseUserRepository;
  SignInUseCase({required this.baseUserRepository});

  Future<Either<Failure, String>> signIn(UserEntity userEntity) async {
    return await baseUserRepository.signIn(userEntity);
  }

  Future<Either<Failure, String>> signUp(UserEntity userEntity) async {
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

  Future<Either<Failure, List<UserEntity>>> getUsersFromCantactsInfo(
      String currentUserId) async {
    return await baseUserRepository.getUsersFromCantactsInfo(currentUserId);
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

class DeleteUserFromGroup {
  BaseUserRepository baseUserRepository;
  DeleteUserFromGroup({required this.baseUserRepository});

  Future<Either<Failure, Unit>> deleteUserFromGroup(
      UserEntity userEntity, String groupId) async {
    return await baseUserRepository.deleteUserFromGroup(userEntity, groupId);
  }
}

class AddUsersToGroup {
  BaseUserRepository baseUserRepository;
  AddUsersToGroup({required this.baseUserRepository});

  Future<Either<Failure, Unit>> addUsersToGroup(
      List<UserEntity> usersEntities, String groupId) async {
    return await baseUserRepository.addUsersToGroup(usersEntities, groupId);
  }
}
