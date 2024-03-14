import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final int dateTime;
  final String senderId;
  final String recieverId;
  final String body;
  final String messageType;

  const MessageEntity(
      {required this.dateTime,
      required this.senderId,
      required this.recieverId,
      required this.body,
      required this.messageType});

  @override
  List<Object?> get props =>
      [dateTime, senderId, recieverId, body, messageType];
}
