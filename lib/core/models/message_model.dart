// ignore_for_file: public_member_api_docs, sort_constructors_first

class MessageModel {
  final int time;
  final String senderId;
  final String recieverId;
  final String message;
  MessageModel({
    required this.time,
    required this.senderId,
    required this.recieverId,
    required this.message,
  });

  MessageModel copyWith({
    int? time,
    String? senderId,
    String? recieverId,
    String? message,
  }) {
    return MessageModel(
      time: time ?? this.time,
      senderId: senderId ?? this.senderId,
      recieverId: recieverId ?? this.recieverId,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time,
      'senderId': senderId,
      'recieverId': recieverId,
      'message': message,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      time: map['time'],
      senderId: map['senderId'],
      recieverId: map['recieverId'],
      message: map['message'],
    );
  }
}
