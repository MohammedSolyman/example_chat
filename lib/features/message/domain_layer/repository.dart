import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import 'entity.dart';

abstract class BaseMessageRepository {
  Future<Either<Failure, Unit>> sendMessage(
      MessageEntity message, String roomId);

  Future<Either<Failure, Unit>> getMessages(
      String roomId, void Function(List<MessageEntity>) callback);
}
