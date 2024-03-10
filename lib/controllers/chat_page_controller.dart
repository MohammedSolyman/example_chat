import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cli_test/core/models/message_model.dart';
import 'package:my_cli_test/core/models/user_model.dart';
import 'package:my_cli_test/models/chat_page_model.dart';

class ChatPageController extends GetxController {
  Rx<ChatPageModel> model = ChatPageModel().obs;

  void getChatInfo(
      {required String roomId,
      required UserModel otherUser,
      required String thisUserId}) {
    model.update((val) {
      //this function will be called at the beginning of the chat page
      //this function will fetch the room, this user and other user information

      val!.roomId = roomId;
      val.thisUserId = thisUserId;
      val.otherUser = otherUser;
    });
  }

  Future<void> sendMessage() async {
// this function will send the message if it is NOT empty
    String msg = model.value.textController.text;
    UserModel otherUser = model.value.otherUser;
    String roomId = model.value.roomId;
    String thisUserId = model.value.thisUserId;
    DateTime now = DateTime.now();
    int nowInNumbers = now.millisecondsSinceEpoch;

    if (msg.isNotEmpty) {
      try {
        FirebaseFirestore myInstance = FirebaseFirestore.instance;
        CollectionReference<Map<String, dynamic>> colRef =
            myInstance.collection('rooms');
        DocumentReference<Map<String, dynamic>> docRef = colRef.doc(roomId);
        CollectionReference<Map<String, dynamic>> msgColRef =
            docRef.collection('messages');

        MessageModel message = MessageModel(
            time: nowInNumbers,
            senderId: thisUserId,
            recieverId: otherUser.id!,
            message: msg);

        await msgColRef.add(message.toMap());

        _clearTextField();
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  void getMessages() {
    //this function will get the stream of the message of this chat room
    String roomId = model.value.roomId;

    FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .collection('messages')
        .snapshots()
        .listen((event) {
      List<QueryDocumentSnapshot> docs = event.docs;
      List<MessageModel> messages = [];

      docs.forEach((element) {
        MessageModel message = MessageModel(
            time: element.get('time'),
            senderId: element.get('senderId'),
            recieverId: element.get('recieverId'),
            message: element.get('message'));

        messages.add(message);
      });

      messages.sort(
        (a, b) => a.time.compareTo(b.time),
      );

      model.update((val) {
        val!.messages = messages;
      });

      messages = [];
    });
  }

  void _clearTextField() {
    model.value.textController.clear();
  }

  String numsToDateString(int dateTimeNums) {
    //convert number to date string
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dateTimeNums);
    String dateTimeString = dateTime.toString();
    String dateString = dateTimeString.split(' ').first;
    return dateString;
  }

  String numsToTimeString(int dateTimeNums) {
    //convert number to time string
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dateTimeNums);
    String dateTimeString = dateTime.toString();
    return dateTimeString.split(' ')[1].split('.').first;
  }
}
