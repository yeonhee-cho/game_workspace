import 'package:flutter/cupertino.dart';
import 'package:game_workspace/widgets/chat/chat_bubble.dart';
import 'package:game_workspace/widgets/chat/empty_message.dart';

import '../../models/chat/chat_message.dart';

class MessageList extends StatelessWidget {
  final List<ChatMessage> messages;

  const MessageList({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return const EmptyMessage();
    }
    return ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ChatBubble(message: messages[index]);
        });
  }
}