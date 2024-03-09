import 'package:flutter/material.dart';

import '../../pages/chat_page.dart';
import '../../pages/contacts_page.dart';
import '../../pages/login_page.dart';
import '../../pages/register_page.dart';
import '../constants/pages_names.dart';

Map<String, Widget Function(BuildContext)> myRoutes = {
  PagesNames.logInPage: (p0) => LoginPage(),
  PagesNames.registerPage: (p0) => RegisterPage(),
  PagesNames.contactsPage: (p0) => const ContactsPage(),
  PagesNames.chatPage: (p0) => const ChatPage(),
};
