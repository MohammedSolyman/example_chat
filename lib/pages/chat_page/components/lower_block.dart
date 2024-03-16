import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/models/user_model.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../features/message/data_layer/model.dart';
import '../../../features/message/presentaion_layer/controller.dart';
import '../../../features/user/presentaion_layer/controller.dart';

class LowerBlock extends StatelessWidget {
  const LowerBlock(
      {required this.roomId,
      required this.currentUser,
      required this.recieverId,
      super.key});

  final String roomId;
  final String recieverId;
  final UserModel currentUser;
  @override
  Widget build(BuildContext context) {
    MessageController messageController = Get.find<MessageController>();
    UserController userControler = Get.find<UserController>();

    TextEditingController tec = TextEditingController();

    return Row(
      children: [
        Expanded(
          child: CustomTextField(
              isPassword: false, isEmail: false, controller: tec),
        ),
        IconButton(
            onPressed: () async {
              if (tec.text.isNotEmpty) {
                MessageModel message = messageController.prepareTextMessage(
                    senderName: currentUser.name,
                    body: tec.text,
                    recieverId: recieverId);

                await messageController.sendTextMessage(
                  message: message,
                  roomId: roomId,
                  context: context,
                );
              }

              tec.clear();
            },
            icon: const Icon(Icons.send))
      ],
    );
  }
}
