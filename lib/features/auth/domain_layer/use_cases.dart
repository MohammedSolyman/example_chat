import 'package:dartz/dartz.dart';

import '../../../core/entities/user_entitie.dart';
import '../../../core/errors/failures.dart';
import 'repository.dart';

class SignUpUseCase {
  BaseAuthRepository baseAuthRepository;
  SignUpUseCase({required this.baseAuthRepository});

  Future<Either<Failure, UserEntity>> signUp(UserEntity userEntity) async {
    return await baseAuthRepository.signUp(userEntity);
  }
}

class SignInUseCase {
  BaseAuthRepository baseAuthRepository;
  SignInUseCase({required this.baseAuthRepository});

  Future<Either<Failure, String>> signIn(UserEntity userEntity) async {
    return await baseAuthRepository.signIn(userEntity);
  }
}

class SignOutUseCase {
  BaseAuthRepository baseAuthRepository;
  SignOutUseCase({required this.baseAuthRepository});

  Future<Either<Failure, Unit>> signOut() async {
    return await baseAuthRepository.signOut();
  }
}

class GetUserInfo {
  BaseAuthRepository baseAuthRepository;
  GetUserInfo({required this.baseAuthRepository});

  Future<Either<Failure, UserEntity>> getUserInfo(String userId) async {
    return await baseAuthRepository.getUserInfo(userId);
  }
}
