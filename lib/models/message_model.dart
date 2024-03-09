class MessageModel {
  final String time;
  final String senderId;
  final String recieverId;
  final String message;

  MessageModel(
      {required this.time,
      required this.senderId,
      required this.recieverId,
      required this.message});
}
