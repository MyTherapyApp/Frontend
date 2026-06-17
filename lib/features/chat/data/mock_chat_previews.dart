import '../models/chat_preview.dart';
import 'mock_users.dart';

final mockChatPreviews = [
  ChatPreview(
    user: mockUsers[0],
    lastMessage: 'Hello Ahmed, how can I help you?',
    time: '5:30 AM',
    unreadCount: 2,
  ),
  ChatPreview(
    user: mockUsers[1],
    lastMessage: 'Your appointment is confirmed.',
    time: 'Yesterday',
    unreadCount: 0,
  ),
  ChatPreview(
    user: mockUsers[2],
    lastMessage: 'Take care of yourself.',
    time: 'Mon',
    unreadCount: 1,
  ),
  ChatPreview(
    user: mockUsers[3],
    lastMessage: 'See you next session.',
    time: 'Sun',
    unreadCount: 0,
  ),
];