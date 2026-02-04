import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController controller;

  final VoidCallback onSend;
  final bool isLoading;

  const MessageInput({
    super.key,
    required this.controller,
    required this.onSend,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: '메세지 입력',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => onSend()),
          ),
          const SizedBox(width: 8),
          IconButton(
              onPressed: isLoading ? null : onSend,
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}