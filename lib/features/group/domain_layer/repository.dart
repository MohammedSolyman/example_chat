import 'package:dartz/dartz.dart';
import 'package:my_cli_test/features/group/domain_layer/entity.dart';
import '../../../core/errors/failures.dart';

abstract class BaseGroupRepository {
  Future<Either<Failure, String>> createGroup(GroupEntity groupEntity);
  Future<Either<Failure, Unit>> renameGroup(GroupEntity groupEntity);
}
