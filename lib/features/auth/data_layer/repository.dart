import 'package:dartz/dartz.dart';
import '../../../core/entities/user_entitie.dart';
import '../../../core/errors/error_messages.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/models/user_model.dart';
import '../../../core/network_info/network_info.dart';
import '../domain_layer/repository.dart';
import 'data_source.dart';

class AuthRepository implements BaseAuthRepository {
  BaseRemoteAuthDataSource baseRemoteAuthDataSource;
  final NetworkInfo networkInfo;

  AuthRepository({
    required this.baseRemoteAuthDataSource,
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
        String userId = await baseRemoteAuthDataSource.signIn(userModel);
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
  Future<Either<Failure, UserEntity>> signUp(UserEntity userEntity) async {
    //if there is internet connection, do the following, otherwose return failure.
    //if there is internet connection, try to sign up this user.
    //if it is successful, retern the user entity,
    //if it is NOT successful, return the corresponding failure

    if (await networkInfo.isConnected) {
      UserModel userModel = UserModel.fromEntity(userEntity);
      try {
        UserModel user = await baseRemoteAuthDataSource.signUp(userModel);

        return Right(user);
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
  Future<Either<Failure, UserModel>> getUserInfo(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        UserModel user = await baseRemoteAuthDataSource.getUserInfo(userId);
        return Right(user);
      } on UnkownException {
        return const Left(
            UnknownFailure(failureMessage: ErrorMessages.unknownError));
      }
    } else {
      return const Left(
          NoConnectionFailure(failureMessage: ErrorMessages.noConnection));
    }
  }
}
