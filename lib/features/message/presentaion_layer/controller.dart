import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/show_my_dialoge.dart';
import '../data_layer/model.dart';
import '../../../core/errors/failures.dart';
import '../../user/data_layer/model.dart';
import '../domain_layer/entity.dart';
import '../domain_layer/use_cases.dart';

class MessageStateModel {
  String roomId = '';
  String thisUserId = '';
  UserModel? otherUser;
  List<MessageModel> messages = [];
}

class MessageController extends GetxController {
  SendMessageUseCase sendMessageUseCase;
  GetMessagesUseCase getMessagesUseCase;
  Rx<MessageStateModel> model = MessageStateModel().obs;

  MessageController({
    required this.sendMessageUseCase,
    required this.getMessagesUseCase,
  });

  void getChatPageInfo(
      {required String roomId,
      UserModel? otherUser,
      required String thisUserId}) {
    //this function will be called at the beginning of the chat page
    //this function will fetch the room, this user (if it is contact
    //NOT group chat) and other user information
    model.update((val) {
      val!.roomId = roomId;
      val.thisUserId = thisUserId;
      val.otherUser = otherUser;
    });
  }

  MessageModel _prepareTextMessage(String body) {
    //prepare the message model

    DateTime now = DateTime.now();
    int dateTime = now.millisecondsSinceEpoch;

    return MessageModel(
      dateTime: dateTime,
      senderId: model.value.thisUserId,
      recieverId: model.value.otherUser!.id!,
      body: body,
      messageType: MessageType.text,
    );
  }

  sendTextMessage({required BuildContext context, required String text}) async {
    //send this message is it is NOT empty.
    if (text.isNotEmpty) {
      MessageModel message = _prepareTextMessage(text);

      Either<Failure, Unit> result =
          await sendMessageUseCase.sendMessage(message, model.value.roomId);

      result.fold((Failure failure) {
        showMyDialog(
            context: context, msg: failure.failureMessage, isSuccess: false);
      }, (Unit unit) {});
    }
  }

  getMessages({required BuildContext context}) async {
    Either<Failure, Unit> result = await getMessagesUseCase.getMessages(
      model.value.roomId,
      (List<MessageEntity> p0) {
        List<MessageModel> messagesModels =
            p0.map((e) => MessageModel.fromEntity(e)).toList();

        model.update((val) {
          val!.messages = messagesModels;
        });
      },
    );

    result.fold((Failure failure) {
      showMyDialog(
          context: context, msg: failure.failureMessage, isSuccess: false);
    }, (Unit unit) {});
  }
}
