import 'package:dartz/dartz.dart';
import '../../../core/entities/user_entitie.dart';
import '../../../core/errors/error_messages.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/models/user_model.dart';
import '../../../core/network_info/network_info.dart';
import '../domain_layer/repository.dart';
import 'data_source.dart';

class UserRepository implements BaseUserRepository {
  BaseRemoteUserDataSource baseRemoteUserDataSource;
  final NetworkInfo networkInfo;

  UserRepository({
    required this.baseRemoteUserDataSource,
    required this.networkInfo,
  });

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
      String userId, void Function(List<UserModel>) callback) async {
    //if there is internet connection, do the following, otherwose return failure.
    //if there is internet connection, try to get all users from contacts collection.
    //if it is NOT successful, return the corresponding failure

    if (await networkInfo.isConnected) {
      try {
        await baseRemoteUserDataSource.getUsersFromCantactsInfo(
            userId, callback);
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
  Future<Either<Failure, Unit>> addGroupToUser(
      UserEntity userEntity, String groupId) async {
    UserModel userModel = UserModel.fromEntity(userEntity);
    if (await networkInfo.isConnected) {
      try {
        await baseRemoteUserDataSource.addGroupToUser(userModel, groupId);
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
  Future<Either<Failure, Unit>> deleteGroupFromUser(
      UserEntity userEntity, String groupId) {
    // TODO: implement deleteGroupFromUser
    throw UnimplementedError();
  }
}
