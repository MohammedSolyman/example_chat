import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../features/message/presentaion_layer/controller.dart';

class LowerBlock extends StatelessWidget {
  const LowerBlock({super.key});
  @override
  Widget build(BuildContext context) {
    MessageController messageController = Get.find<MessageController>();

    TextEditingController tec = TextEditingController();

    return Row(
      children: [
        Expanded(
          child: CustomTextField(
              isPassword: false, isEmail: false, controller: tec),
        ),
        IconButton(
            onPressed: () async {
              await messageController.sendTextMessage(
                context: context,
                text: tec.text,
              );

              tec.clear();
            },
            icon: const Icon(Icons.send))
      ],
    );
  }
}
