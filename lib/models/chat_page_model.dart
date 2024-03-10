import 'package:flutter/material.dart';
import 'package:my_cli_test/core/models/message_model.dart';

import '../core/models/user_model.dart';

class ChatPageModel {
  String roomId = '';
  late UserModel otherUser;
  String thisUserId = ''; //the current user
  List<MessageModel> messages = [];
  TextEditingController textController = TextEditingController();
}
