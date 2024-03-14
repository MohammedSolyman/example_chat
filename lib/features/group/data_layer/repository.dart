import 'package:dartz/dartz.dart';
import 'package:my_cli_test/core/errors/error_messages.dart';

import 'package:my_cli_test/core/errors/failures.dart';
import 'data_source.dart';
import 'model.dart';
import 'package:my_cli_test/features/group/domain_layer/entity.dart';

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
}
