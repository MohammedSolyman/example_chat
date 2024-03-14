import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'model.dart';
import '../../../core/errors/exceptions.dart';

abstract class BaseRemoteMessageDataSource {
  Future<Unit> sendMessage(MessageModel message, String roomId);

  Future<Unit> getMessages(
      String roomId, void Function(List<MessageModel>) callback);
}

class RemoteMessageDataSource implements BaseRemoteMessageDataSource {
  @override
  Future<Unit> sendMessage(MessageModel message, String roomId) async {
    //try to send this message to the chat Id.
    //if it NOT successful throw the corresponding exceptions.

    //detecting if it is contacts room or group room
    String collection =
        roomId.startsWith('contact') ? 'contacts rooms' : 'groups rooms';

    try {
      // FirebaseFirestore myInstance = FirebaseFirestore.instance;
      // CollectionReference<Map<String, dynamic>> colRef =
      //     myInstance.collection(collection);
      // DocumentReference<Map<String, dynamic>> docRef = colRef.doc(roomId);
      // CollectionReference<Map<String, dynamic>> msgColRef =
      //     docRef.collection('messages');

      CollectionReference<Map<String, dynamic>> msgColRef = FirebaseFirestore
          .instance
          .collection(collection)
          .doc(roomId)
          .collection('messages');

      Map x = message.toMap();
      x.forEach((key, value) {});
      await msgColRef.add(message.toMap());

      return unit;
    } catch (e) {
      throw UnkownException();
    }
  }

  @override
  Future<Unit> getMessages(
      String roomId, void Function(List<MessageModel>) callback) async {
    //try to get the messages from the chat Id.
    //if it NOT successful throw the corresponding exceptions.

    //detecting if it is contacts room or group room
    String collection =
        roomId.startsWith('contact') ? 'contacts rooms' : 'groups rooms';
    List<MessageModel> messages = [];

    try {
      FirebaseFirestore.instance
          .collection(collection)
          .doc(roomId)
          .collection('messages')
          .snapshots()
          .listen((event) {
        List<QueryDocumentSnapshot> docs = event.docs;

        docs.forEach((element) {
          MessageModel message = MessageModel(
            dateTime: element.get('dateTime'),
            senderId: element.get('senderId'),
            senderName: element.get('senderName'),
            recieverId: element.get('recieverId'),
            body: element.get('body'),
            messageType: element.get('messageType'),
          );

          messages.add(message);
        });

        //sort all messages
        messages.sort(
          (a, b) => a.dateTime.compareTo(b.dateTime),
        );

        callback(messages);
        messages = [];
      });
      return unit;
    } catch (e) {
      throw UnkownException();
    }
  }
}
