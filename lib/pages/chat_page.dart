import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('chat page'),
            ElevatedButton(onPressed: () {}, child: const Text('to home page'))
          ],
        ),
      ),
    );
  }
}
