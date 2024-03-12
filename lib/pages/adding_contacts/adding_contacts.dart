import 'package:flutter/material.dart';
import 'package:my_cli_test/core/widgets/custom_title.dart';

class AddingContacts extends StatelessWidget {
  const AddingContacts({required this.groupName, super.key});

  final String groupName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomTitle(text: 'Creating "$groupName"')),
    );
  }
}
