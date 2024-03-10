import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_cli_test/models/contacts_page_model.dart';

import '../core/models/user_model.dart';

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
}
