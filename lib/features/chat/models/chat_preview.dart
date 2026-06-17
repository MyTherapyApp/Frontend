import 'chat_user.dart';

class ChatPreview {
  final ChatUser user;
  final String lastMessage;
  final String time;
  final int unreadCount;

  ChatPreview({
    required this.user,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
  });
}