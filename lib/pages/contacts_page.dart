import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../core/constants/app_strings.dart';
import '../models/user_model.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({required this.userId, super.key});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.contacts)),
      body: Center(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection("contacts").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('errrrrrrrrrrroooooooooooor');
            return Text('errrrrroooooor');
          } else if (snapshot.hasData) {
            List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
            List<UserModel> users = [];
            docs.forEach((element) {
              UserModel user = UserModel(
                  id: element.get('id'),
                  name: element.get('name'),
                  email: element.get('email'));
              users.add(user);
            });
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Text(users[index].name!);
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      )),
    );
  }
}
