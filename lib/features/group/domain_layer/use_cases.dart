import 'package:dartz/dartz.dart';
import 'entity.dart';
import 'repository.dart';
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
