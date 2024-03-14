import 'package:dartz/dartz.dart';

import '../../../core/errors/error_messages.dart';
import '../../../core/errors/failures.dart';
import '../domain_layer/entity.dart';
import 'data_source.dart';
import 'model.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/network_info/network_info.dart';
import '../domain_layer/repository.dart';

class GroupRepository implements BaseGroupRepository {
  final BaseRemoteGroupDataSource baseRemoteGroupDataSource;
  final NetworkInfo networkInfo;

  GroupRepository(
      {required this.baseRemoteGroupDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, String>> createGroup(GroupEntity groupEntity) async {
    GroupModel groupModel = GroupModel.fromEntity(groupEntity);
    if (await networkInfo.isConnected) {
      try {
        String groupId =
            await baseRemoteGroupDataSource.createGroup(groupModel);
        return Right(groupId);
      } on ServerException {
        return const Left(
            ServerFailure(failureMessage: ErrorMessages.serverError));
      }
    } else {
      return const Left(
          NoConnectionFailure(failureMessage: ErrorMessages.noConnection));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateGroup(GroupEntity groupEntity) async {
    GroupModel groupModel = GroupModel.fromEntity(groupEntity);
    if (await networkInfo.isConnected) {
      try {
        await baseRemoteGroupDataSource.updateGroup(groupModel);
        return const Right(unit);
      } on ServerException {
        return const Left(
            ServerFailure(failureMessage: ErrorMessages.serverError));
      }
    } else {
      return const Left(
          NoConnectionFailure(failureMessage: ErrorMessages.noConnection));
    }
  }

  @override
  Future<Either<Failure, Unit>> addUsersGroup(
      List<String> usersIds, String groupId) async {
    if (await networkInfo.isConnected) {
      try {
        await baseRemoteGroupDataSource.addUsersGroup(usersIds, groupId);
        return const Right(unit);
      } on ServerException {
        return const Left(
            ServerFailure(failureMessage: ErrorMessages.serverError));
      }
    } else {
      return const Left(
          NoConnectionFailure(failureMessage: ErrorMessages.noConnection));
    }
  }
}
