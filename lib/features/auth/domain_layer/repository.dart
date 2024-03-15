import 'package:dartz/dartz.dart';
import '../../../core/entities/user_entitie.dart';
import '../../../core/errors/failures.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, UserEntity>> signUp(UserEntity userEntity);
  Future<Either<Failure, String>> signIn(UserEntity userEntity);
  Future<Either<Failure, Unit>> signOut(UserEntity userEntity);
  Future<Either<Failure, UserEntity>> getUserInfo(String userId);
}
