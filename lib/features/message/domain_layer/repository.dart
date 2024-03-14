import 'package:dartz/dartz.dart';
import 'package:my_cli_test/features/message/domain_layer/entity.dart';
import '../../../core/errors/failures.dart';

abstract class BaseMessageRepository {
  Future<Either<Failure, Unit>> sendMessage(
      MessageEntity message, String roomId);

  Future<Either<Failure, Unit>> getMessages(
      String roomId, void Function(List<MessageEntity>) callback);
}
