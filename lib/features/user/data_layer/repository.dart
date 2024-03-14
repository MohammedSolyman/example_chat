import 'package:dartz/dartz.dart';
import 'package:my_cli_test/core/errors/error_messages.dart';
import 'package:my_cli_test/core/errors/exceptions.dart';

import 'package:my_cli_test/core/errors/failures.dart';
import 'package:my_cli_test/core/network_info/network_info.dart';
import 'package:my_cli_test/features/user/data_layer/data_source.dart';
import 'package:my_cli_test/features/user/data_layer/model.dart';
import 'package:my_cli_test/features/user/domain_layer/entity.dart';

import '../domain_layer/repository.dart';

class UserRepository implements BaseUserRepository {
  BaseRemoteUserDataSource baseRemoteUserDataSource;
  final NetworkInfo networkInfo;

  UserRepository({
    required this.baseRemoteUserDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, String>> signIn(UserEntity userEntity) async {
    //if there is internet connection, do the following, otherwose return failure.
    //if there is internet connection, try to sign in this user.
    //if it is NOT successful, return the corresponding failure

    if (await networkInfo.isConnected) {
      UserModel userModel = UserModel.fromEntity(userEntity);
      try {
        String userId = await baseRemoteUserDataSource.signIn(userModel);
        return Right(userId);
      } on NotFoundExeption {
        return const Left(
            NotFoundFailure(failureMessage: ErrorMessages.notFoundError));
      } on WrongPasswordExeption {
        return const Left(WrongPasswordFailure(
            failureMessage: ErrorMessages.wrongPasswordError));
      } on InvalidCredentialExeption {
        return const Left(InvalidCredentialFailure(
            failureMessage: ErrorMessages.invalidCredentialError));
      } on UnkownException {
        return const Left(
            UnknownFailure(failureMessage: ErrorMessages.unknownError));
      }
    } else {
      return const Left(
          NoConnectionFailure(failureMessage: ErrorMessages.noConnection));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut(UserEntity userEntity) async {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUp(UserEntity userEntity) async {
    //if there is internet connection, do the following, otherwose return failure.
    //if there is internet connection, try to sign up this user.
    //if it is successful, retern the user id,
    //if it is NOT successful, return the corresponding failure

    if (await networkInfo.isConnected) {
      UserModel userModel = UserModel.fromEntity(userEntity);
      try {
        String userId = await baseRemoteUserDataSource.signUp(userModel);
        return Right(userId);
      } on WeakPasswordException {
        return const Left(WeakPasswordFailure(
            failureMessage: ErrorMessages.weakPasswordError));
      } on AlreadySingedUpException {
        return const Left(AlreadySingedUpFailure(
            failureMessage: ErrorMessages.alreadySingedUpError));
      } on UnkownException {
        return const Left(
            UnknownFailure(failureMessage: ErrorMessages.unknownError));
      }
    } else {
      return const Left(
          NoConnectionFailure(failureMessage: ErrorMessages.noConnection));
    }
  }

  @override
  Future<Either<Failure, Unit>> addUserToContactInfo(
      UserEntity userEntity) async {
    //if there is internet connection, do the following, otherwose return failure.
    //if there is internet connection, try to add this user to (contacts info) collection.
    //if it is NOT successful, return the corresponding failure

    if (await networkInfo.isConnected) {
      UserModel userModel = UserModel.fromEntity(userEntity);
      try {
        await baseRemoteUserDataSource.addUserToContactInfo(userModel);
        return const Right(unit);
      } on UnkownException {
        return const Left(
            UnknownFailure(failureMessage: ErrorMessages.unknownError));
      }
    } else {
      return const Left(
          NoConnectionFailure(failureMessage: ErrorMessages.noConnection));
    }
  }

  @override
  Future<Either<Failure, Unit>> getUsersFromCantactsInfo(
      String currentUserId, void Function(List<UserModel>) callback) async {
    //if there is internet connection, do the following, otherwose return failure.
    //if there is internet connection, try to get all users from contacts collection.
    //if it is NOT successful, return the corresponding failure

    if (await networkInfo.isConnected) {
      try {
        await baseRemoteUserDataSource.getUsersFromCantactsInfo(
            currentUserId, callback);
        return const Right(unit);
      } on UnkownException {
        return const Left(
            UnknownFailure(failureMessage: ErrorMessages.unknownError));
      }
    } else {
      return const Left(
          NoConnectionFailure(failureMessage: ErrorMessages.noConnection));
    }
  }

  @override
  Future<Either<Failure, Unit>> addUsersToGroup(
      List<UserEntity> usersEntities, String groupId) {
    // TODO: implement addUsersToGroup
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteUserFromGroup(
      UserEntity userEntity, String groupId) {
    // TODO: implement deleteUserFromGroup
    throw UnimplementedError();
  }
}
