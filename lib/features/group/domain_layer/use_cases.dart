import 'package:dartz/dartz.dart';
import 'package:my_cli_test/features/group/domain_layer/entity.dart';
import 'package:my_cli_test/features/group/domain_layer/repository.dart';

import '../../../core/errors/failures.dart';

class CreateGroupUseCase {
  BaseGroupRepository baseGroupRepository;
  CreateGroupUseCase({required this.baseGroupRepository});

  Future<Either<Failure, String>> createGroup(GroupEntity groupEntity) async {
    return await baseGroupRepository.createGroup(groupEntity);
  }
}

class RenameGroupUseCase {
  BaseGroupRepository baseGroupRepository;
  RenameGroupUseCase({required this.baseGroupRepository});

  Future<Either<Failure, Unit>> renameGroup(GroupEntity groupEntity) async {
    return await baseGroupRepository.renameGroup(groupEntity);
  }
}
