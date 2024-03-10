import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cli_test/controllers/chat_page_controller.dart';
import 'package:my_cli_test/core/constants/assets_paths.dart';
import 'package:my_cli_test/core/widgets/custom_text.dart';
import 'package:my_cli_test/core/widgets/custom_text_field.dart';
import 'package:my_cli_test/core/widgets/custom_title.dart';
import '../core/models/message_model.dart';
import '../core/models/user_model.dart';

class ChatPage extends StatelessWidget {
  const ChatPage(
      {required this.roomId,
      required this.otherUser,
      required this.thisUserId,
      super.key});

  final String roomId;
  final UserModel otherUser;
  final String thisUserId;

  @override
  Widget build(BuildContext context) {
    ChatPageController controller = Get.put(ChatPageController());
    controller.getChatInfo(
        roomId: roomId, otherUser: otherUser, thisUserId: thisUserId);
    controller.getMessages();

    return Scaffold(
      appBar: AppBar(
          title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTitle(text: otherUser.name!),
          CustomText(
            text: otherUser.email,
            isSamll: true,
          )
        ],
      )),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AssetsPaths.background), fit: BoxFit.fill)),
        child: const Center(
          child: Column(
            children: [ChatBody(), LowerBlock()],
          ),
        ),
      ),
    );
  }
}

class LowerBlock extends StatelessWidget {
  const LowerBlock({super.key});

  @override
  Widget build(BuildContext context) {
    ChatPageController controller = Get.put(ChatPageController());

    return Row(
      children: [
        Expanded(
          child: CustomTextField(
              isEmail: false,
              controller: controller.model.value.textController),
        ),
        IconButton(
            onPressed: () async {
              await controller.sendMessage();
              controller.getMessages();
            },
            icon: const Icon(Icons.send))
      ],
    );
  }
}

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    ChatPageController controller = Get.put(ChatPageController());

    return Obx(() {
      List<MessageModel> messages = controller.model.value.messages;

      return Expanded(
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return MessageTile(message: messages[index]);
          },
        ),
      );
    });
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile({required this.message, super.key});

  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    ChatPageController controller = Get.put(ChatPageController());

    return Obx(() {
      String msg = message.message;
      bool isMe = message.senderId == controller.model.value.thisUserId;
      DateTime timeInNumbers =
          DateTime.fromMillisecondsSinceEpoch(message.time.toInt());
      String timeString = timeInNumbers.toString();
      print('-------------------------');
      print(timeString);
      return MessageBlock(
        isMe: isMe,
        msg: msg,
        time: timeString,
      );
    });
  }
}

class MessageBlock extends StatelessWidget {
  const MessageBlock(
      {required this.isMe, required this.msg, required this.time, super.key});

  final bool isMe;
  final String msg;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: isMe ? Theme.of(context).primaryColorLight : Colors.white,
            //   border: Border.all(color: Colors.black),
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
          children: [Text(msg), Text(time)],
        ),
      ),
    );
  }
}
