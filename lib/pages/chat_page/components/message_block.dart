import 'package:flutter/material.dart';

class MessageBlock extends StatelessWidget {
  const MessageBlock(
      {required this.isMe,
      required this.msg,
      required this.time,
      required this.isGroup,
      this.senderName,
      super.key});

  final bool isMe;
  final String msg;
  final String time;
  final String? senderName;
  final bool isGroup;
  @override
  Widget build(BuildContext context) {
    List<Widget> messageChildren = [];
    if (isGroup) {
      messageChildren.add(Text(senderName!));
    }
    messageChildren.addAll([Text(msg), Text(time)]);
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: isMe ? Theme.of(context).primaryColorLight : Colors.white,
            borderRadius: BorderRadius.only(
              topRight:
                  isMe ? const Radius.circular(5) : const Radius.circular(15),
              topLeft:
                  isMe ? const Radius.circular(15) : const Radius.circular(5),
              bottomLeft: const Radius.circular(5),
              bottomRight: const Radius.circular(5),
            )),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: messageChildren,
        ),
      ),
    );
  }
}
