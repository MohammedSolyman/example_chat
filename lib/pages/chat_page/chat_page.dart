import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cli_test/pages/chat_page/components/chat_appbar.dart';
import 'package:my_cli_test/pages/chat_page/components/chat_body.dart';
import 'package:my_cli_test/pages/chat_page/components/lower_block.dart';
import '../../controllers/chat_page_controller.dart';
import '../../core/constants/assets_paths.dart';
import '../../core/models/user_model.dart';
import '../../core/widgets/custom_text.dart';
import '../../core/widgets/custom_title.dart';

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
      appBar: chatAppBar(otherUser),
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
