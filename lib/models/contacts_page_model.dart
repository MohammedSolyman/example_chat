import 'package:flutter/material.dart';

import '../core/models/user_model.dart';

class ContactsPageModel {
  List<UserModel>? users;
  String currentUserId = '';
  final TextEditingController groupTec = TextEditingController();
}
