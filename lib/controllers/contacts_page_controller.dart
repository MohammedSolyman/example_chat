import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../core/models/user_model.dart';
import '../models/contacts_page_model.dart';
import '../pages/chat_page.dart';

class ContactsPageController extends GetxController {
  Rx<ContactsPageModel> model = ContactsPageModel().obs;

  void getContacts() {
    List<UserModel> users = [];

    FirebaseFirestore.instance
        .collection("contacts")
        .snapshots()
        .listen((event) {
      List<QueryDocumentSnapshot> docs = event.docs;

      docs.forEach((element) {
        UserModel user = UserModel(
            id: element.get('id'),
            name: element.get('name'),
            email: element.get('email'));

        if (user.id != model.value.currentUserId) {
          users.add(user);
        }
      });

      users.sort(
        (a, b) => a.name!.compareTo(b.name!),
      );

      model.update((val) {
        val!.users = users;
      });
    });
  }

  void getCurrentUserId(String id) {
    model.update((val) {
      val!.currentUserId = id;
    });
  }

  String _creaetRoomId(String recieverUserId) {
    List<String> idsCombination = [model.value.currentUserId, recieverUserId];
    idsCombination.sort(
      (a, b) => a.compareTo(b),
    );
    return '${idsCombination[0]}-${idsCombination[1]}';
  }

  Future<void> goToChatPage(UserModel recieverUser) async {
    String roomId = _creaetRoomId(recieverUser.id!);

    await Get.to(ChatPage(
      roomId: roomId,
      otherUser: recieverUser,
      thisUserId: model.value.currentUserId,
    ));
  }
}
