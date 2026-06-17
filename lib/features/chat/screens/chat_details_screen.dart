import 'package:flutter/material.dart';

import '../models/chat_user.dart';
import '../data/mock_messages.dart';
import '../widgets/custom_gradient_appbar.dart';

const int currentUserId = 6;
class ChatDetailsScreen extends StatelessWidget {
  final ChatUser user;
  const ChatDetailsScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomGradientAppBar(
        userName: user.name,
        avatar: CircleAvatar(
          radius: 20,
          child: Text(
            user.name[0],
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(
  child: ListView.builder(
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 16,
    ),
    itemCount: mockMessages.length,
    itemBuilder: (context, index) {
      final message = mockMessages[index];

      final isMe =
          message.senderId == currentUserId;

      return Align(
        alignment: isMe
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(
            bottom: 10,
          ),
          constraints: BoxConstraints(
            maxWidth:
                MediaQuery.of(context).size.width *
                    0.75,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: isMe
                ? const Color(0xFFE7EEFF)
                : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(18),
              topRight: const Radius.circular(18),
              bottomLeft: Radius.circular(
                isMe ? 18 : 4,
              ),
              bottomRight: Radius.circular(
                isMe ? 4 : 18,
              ),
            ),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [
              Text(
                message.text,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    },
  ),
),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
  child: TextField(
    decoration: InputDecoration(
      hintText: 'Message',
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 12,
      ),
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(30),
        borderSide: BorderSide.none,
      
      ),
    ),
  ),
),

                const SizedBox(width: 8),

                CircleAvatar(
  radius: 22,
  backgroundColor:
      const Color(0xFF8B7CF8),
  child: IconButton(
    onPressed: () {},
    icon: const Icon(
      Icons.send,
      color: Colors.white,
      size: 20,
    ),
  ),
),
              ],
            ),
          ),
        ],
      ),
    );
  }
}