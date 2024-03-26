// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import '../../../core/errors/error_messages.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../domain_layer/entity.dart';
import 'model.dart';
import '../../../core/network_info/network_info.dart';
import '../domain_layer/repository.dart';
import 'data_source.dart';

class MessageRepository implements BaseMessageRepository {
  final BaseRemoteMessageDataSource baseRemoteMessageDataSource;
  final NetworkInfo networkInfo;
  MessageRepository({
    required this.baseRemoteMessageDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> sendMessage(
      MessageEntity message, String roomId) async {
    //if there is internet connection, do the following, otherwise return failure.
    //if there is internet connection, try to send the message to room Id.
    //if it is NOT successful, return the corresponding failure

    if (await networkInfo.isConnected) {
      MessageModel messageModel = MessageModel.fromEntity(message);
      try {
        await baseRemoteMessageDataSource.sendMessage(messageModel, roomId);

        return const Right(unit);
      } on UnkownException {
        return const Left(
            UnknownFailure(failureMessage: ErrorMessages.unknownError));
      }
    } else {
      return const Left(
          NoConnectionFailure(failureMessage: ErrorMessages.noConnection));
    }
  }

  @override
  Future<Either<Failure, Unit>> getMessages(
      String roomId, void Function(List<MessageModel>) callback) async {
    //if there is internet connection, do the following, otherwise return failure.
    //if there is internet connection, try to get messages from room Id.
    //if it is NOT successful, return the corresponding failure

    if (await networkInfo.isConnected) {
      try {
        await baseRemoteMessageDataSource.getMessages(roomId, callback);

        return const Right(unit);
      } on UnkownException {
        return const Left(
            UnknownFailure(failureMessage: ErrorMessages.unknownError));
      }
    } else {
      return const Left(
          NoConnectionFailure(failureMessage: ErrorMessages.noConnection));
    }
  }
}
