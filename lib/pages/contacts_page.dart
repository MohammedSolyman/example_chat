import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../core/constants/app_strings.dart';
import '../models/user_model.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map arg = ModalRoute.of(context)!.settings.arguments as Map;
    final String userId = arg['id'].toString();

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.contacts)),
      body: Center(
          child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("contacts").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('errrrrrrrrrrroooooooooooor');
            return Text('errrrrroooooor');
          } else if (snapshot.hasData) {
            print(snapshot.data.toString());
            List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
            List<UserModel> users = [];
            docs.forEach((element) {
              UserModel user = UserModel(
                  name: element.get('id'), email: element.get('email'));
              users.add(user);
            });
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Text(users[index].name);
              },
            );
          }
          return CircularProgressIndicator();
        },
      )),
    );
  }
}
