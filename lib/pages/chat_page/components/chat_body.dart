import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../features/message/data_layer/model.dart';
import '../../../features/message/presentaion_layer/controller.dart';
import 'message_tile/message_tile.dart';
import 'message_tile/time_tile.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({required this.isGroup, super.key});

  final bool isGroup;
  @override
  Widget build(BuildContext context) {
    MessageController messageController = Get.find<MessageController>();
    String tempDate = '';

    return Obx(() {
      List<MessageModel> messages = messageController.model.value.messages;

      return Expanded(
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            List<Widget> widgetsList = [];

            String date = messages[index].getDateString();

            if (index == 0) {
              tempDate = date;
              widgetsList.add(TimeTile(date: date));
            } else {
              if (tempDate != date) {
                tempDate = date;
                widgetsList.add(TimeTile(date: date));
              }
            }

            widgetsList
                .add(MessageTile(isGroup: isGroup, message: messages[index]));

            return Column(
              children: widgetsList,
            );
          },
        ),
      );
    });
  }
}
