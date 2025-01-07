import 'package:flutter/material.dart';

// lib/screens/chat_screen.dart
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messages = [];
  final _controller = TextEditingController();

  void sendMessage(String message) {
    // Implement message sending logic
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_messages[index]),
              );
            },
          ),
        ),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Type a message...',
          ),
        ),
      ],
    );
  }
}
