import 'package:cloud_firestore/cloud_firestore.dart';
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
      val!.roomId = roomId;
      val.thisUserId = thisUserId;
      val.otherUser = otherUser;
    });
  }

  Future<void> sendMessage() async {
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
        print('---------------------------');
        print(e.toString());
      }
    }
  }

  // Future<void> getAllMessages() async {
  //   String roomId = model.value.roomId;

  //   List<MessageModel> messages = [];

  //   CollectionReference<Map<String, dynamic>> colRef = FirebaseFirestore
  //       .instance
  //       .collection("rooms")
  //       .doc(roomId)
  //       .collection('messages');

  //   QuerySnapshot<Map<String, dynamic>> querySS = await colRef.get();
  //   List<QueryDocumentSnapshot<Map<String, dynamic>>> myList = querySS.docs;

  //   myList.forEach((QueryDocumentSnapshot<Map<String, dynamic>> element) {
  //     Map<String, dynamic> map = element.data();
  //     MessageModel message = MessageModel.fromMap(map);
  //     messages.add(message);
  //   });
  //   messages.sort(
  //     (a, b) => a.time.compareTo(b.time),
  //   );

  //   print('-------------------');
  //   messages.forEach((element) {
  //     print(element.message);
  //   });

  //   model.update((val) {
  //     val!.messages = messages;
  //   });
  // }

  void getMessages() {
    String roomId = model.value.roomId;

    FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .collection('messages')
        .snapshots()
        .listen((event) {
      List<QueryDocumentSnapshot> docs = event.docs;
      // List<DocumentChange<Map<String, dynamic>>> docs = event.docChanges;

      // QueryDocumentSnapshot lastData = docs.last;

      // MessageModel lastMessage = MessageModel(
      //     time: lastData.get('time'),
      //     senderId: lastData.get('senderId'),
      //     recieverId: lastData.get('recieverId'),
      //     message: lastData.get('message'));

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
}
