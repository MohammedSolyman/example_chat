// import 'package:flutter/material.dart';

// class MessageBlock extends StatelessWidget {
//   const MessageBlock(
//       {required this.isMe,
//       required this.msg,
//       required this.time,
//       required this.isGroup,
//       this.senderName,
//       super.key});

//   final bool isMe;
//   final String msg;
//   final String time;
//   final String? senderName;
//   final bool isGroup;
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> messageChildren = [];
//     if (isGroup) {
//       messageChildren.add(Text(senderName!));
//     }
//     messageChildren.addAll([Text(msg), Text(time)]);
//     return Align(
//       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         padding: const EdgeInsets.all(5),
//         margin: const EdgeInsets.all(5),
//         decoration: BoxDecoration(
//             color: isMe ? Theme.of(context).primaryColorLight : Colors.white,
//             borderRadius: BorderRadius.only(
//               topRight:
//                   isMe ? const Radius.circular(5) : const Radius.circular(15),
//               topLeft:
//                   isMe ? const Radius.circular(15) : const Radius.circular(5),
//               bottomLeft: const Radius.circular(5),
//               bottomRight: const Radius.circular(5),
//             )),
//         child: Column(
//           crossAxisAlignment:
//               isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: messageChildren,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../features/message/data_layer/model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MessageSubTile extends StatelessWidget {
  const MessageSubTile(
      {required this.isMe,
      required this.msg,
      required this.time,
      required this.isGroup,
      this.senderName,
      required this.messageType,
      super.key});

  final bool isMe;
  final String msg;
  final String messageType;
  final String time;
  final String? senderName;
  final bool isGroup;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (isGroup) Text(senderName!),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color:
                      isMe ? Theme.of(context).primaryColorLight : Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: isMe
                        ? const Radius.circular(5)
                        : const Radius.circular(15),
                    topLeft: isMe
                        ? const Radius.circular(15)
                        : const Radius.circular(5),
                    bottomLeft: const Radius.circular(5),
                    bottomRight: const Radius.circular(5),
                  )),
              child: MessageBody(messageType: messageType, messageBody: msg),
            ),
            CustomText(
              text: time,
              isSamll: true,
            )
          ],
        ),
      ),
    );
  }
}

class MessageBody extends StatelessWidget {
  const MessageBody(
      {super.key, required this.messageType, required this.messageBody});

  final String messageType;
  final String messageBody;

  @override
  Widget build(BuildContext context) {
    if (messageType == MessageType.text) {
      return Text(messageBody);
    } else if (messageType == MessageType.image) {
      return SizedBox(
          height: 230,
          width: 150,
          child: CachedNetworkImage(
            imageUrl: messageBody,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ));
    } else {
      return Container();
    }
  }
}
