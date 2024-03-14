import 'package:dartz/dartz.dart';
import 'entity.dart';
import '../../../core/errors/failures.dart';
import 'repository.dart';

class SendMessageUseCase {
  BaseMessageRepository baseMessageRepository;
  SendMessageUseCase({required this.baseMessageRepository});

  Future<Either<Failure, Unit>> sendMessage(
      MessageEntity message, String roomId) async {
    return await baseMessageRepository.sendMessage(message, roomId);
  }
}

class GetMessagesUseCase {
  BaseMessageRepository baseMessageRepository;
  GetMessagesUseCase({required this.baseMessageRepository});

  Future<Either<Failure, Unit>> getMessages(
      String roomId, void Function(List<MessageEntity>) callback) async {
    return await baseMessageRepository.getMessages(roomId, callback);
  }
}
