import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cli_test/controllers/chat_page_controller.dart';
import 'package:my_cli_test/core/widgets/custom_text_field.dart';

class LowerBlock extends StatelessWidget {
  const LowerBlock({super.key});

  @override
  Widget build(BuildContext context) {
    ChatPageController controller = Get.put(ChatPageController());

    return Row(
      children: [
        Expanded(
          child: CustomTextField(
              isPassword: false,
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
