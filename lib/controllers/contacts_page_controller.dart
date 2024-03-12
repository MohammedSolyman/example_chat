import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../core/models/user_model.dart';
import '../models/contacts_page_model.dart';
import '../pages/adding_contacts/adding_contacts.dart';
import '../pages/chat_page/chat_page.dart';

class ContactsPageController extends GetxController {
  Rx<ContactsPageModel> model = ContactsPageModel().obs;

  void getContacts() {
    // get a list of all users

    FirebaseFirestore.instance
        .collection("contacts info")
        .snapshots()
        .listen((event) {
      List<UserModel> users = [];

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

      users = [];
    });
  }

  void getCurrentUserId(String id) {
    //this function fetches this user id
    model.update((val) {
      val!.currentUserId = id;
    });
  }

  String _creaetRoomId(String recieverUserId) {
    // this function generate an ID to this chat room, by combining the ID's
    //of the two users after sorting them
    List<String> idsCombination = [model.value.currentUserId, recieverUserId];
    idsCombination.sort(
      (a, b) => a.compareTo(b),
    );
    return '${idsCombination[0]}-${idsCombination[1]}';
  }

  Future<void> goToChatPage(UserModel recieverUser) async {
    //navigate to chat page
    String roomId = _creaetRoomId(recieverUser.id!);

    await Get.to(ChatPage(
      roomId: roomId,
      otherUser: recieverUser,
      thisUserId: model.value.currentUserId,
    ));
  }

  void cancelGroup() {
    _clearTextField();
    Get.back();
  }

  void createGroup() {
    if (model.value.groupTec.text.isNotEmpty) {
      _goToAdingContacts(model.value.groupTec.text);
      _clearTextField();
    }
  }

  void _goToAdingContacts(String groupName) {
    Get.to(() => AddingContacts(groupName: groupName));
  }

  void _clearTextField() {
    model.value.groupTec.clear();
  }
}
