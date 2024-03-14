import 'package:my_cli_test/features/message/domain_layer/entity.dart';
import 'package:intl/intl.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.dateTime,
    required super.senderId,
    required super.recieverId,
    required super.body,
    required super.messageType,
  });

  MessageModel copyWith(
      {int? dateTime,
      String? senderId,
      String? recieverId,
      String? body,
      String? messageType}) {
    return MessageModel(
        dateTime: dateTime ?? this.dateTime,
        senderId: senderId ?? this.senderId,
        recieverId: recieverId ?? this.recieverId,
        body: body ?? this.body,
        messageType: messageType ?? this.messageType);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateTime': dateTime,
      'senderId': senderId,
      'recieverId': recieverId,
      'body': body,
      'messageType': messageType
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
        dateTime: map['dateTime'],
        senderId: map['senderId'],
        recieverId: map['recieverId'],
        body: map['body'],
        messageType: map['messageType']);
  }

  factory MessageModel.fromEntity(MessageEntity messageEntity) {
    return MessageModel(
        dateTime: messageEntity.dateTime,
        senderId: messageEntity.senderId,
        recieverId: messageEntity.recieverId,
        body: messageEntity.body,
        messageType: messageEntity.messageType);
  }

  String getDateString() {
    //extract the date of this message
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(this.dateTime.toInt());
    String dateTimeString = dateTime.toString();
    String dateString = dateTimeString.split(' ').first;
    return dateString;
  }

  String getimeString() {
    //extract the time of this message and convert it frim (24 hour format)
    // to (12 hour format)
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(this.dateTime.toInt());
    return DateFormat('hh:mm a').format(dateTime);
  }
}

class MessageType {
  static const text = 'text';
  static const image = 'image';
  static const audio = 'audio';
}
