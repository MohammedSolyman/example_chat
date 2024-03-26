import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/models/user_model.dart';
import '../../../features/file/data_layer/model.dart';
import '../../../features/file/presentaion_layer/controller.dart';
import '../../../features/message/data_layer/model.dart';
import '../../../features/message/presentaion_layer/controller.dart';

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
    FileController fileControler = Get.find<FileController>();

    TextEditingController tec = TextEditingController();

    return Row(
      children: [
        Expanded(
          child: TextFormField(
              minLines: 1,
              maxLines: 5,
              controller: tec,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () async {
                      // ask user to pick a file
                      File? file = await fileControler.pickFileFunction();

                      if (file != null) {
                        // if the user picks a file send this image message
                        FileModel fileModel = fileControler.prepareMesageFile(
                            file: file, roomId: roomId);

                        String? downloadLink =
                            await fileControler.createFileFunction(fileModel);

                        MessageModel message = messageController.prepareMessage(
                            messageType: MessageType.image,
                            senderName: currentUser.name,
                            body: downloadLink!,
                            recieverId: recieverId);

                        await messageController.sendMessage(
                          message: message,
                          roomId: roomId,
                          context: context,
                        );
                      }
                    },
                    icon: const Icon(Icons.attach_file)),
                fillColor: Colors.white,
                filled: true,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 142, 23, 23),
                  ),
                ),
              )),
        ),
        IconButton(
            onPressed: () async {
              if (tec.text.isNotEmpty) {
                MessageModel message = messageController.prepareMessage(
                    messageType: MessageType.text,
                    senderName: currentUser.name,
                    body: tec.text,
                    recieverId: recieverId);

                await messageController.sendMessage(
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
