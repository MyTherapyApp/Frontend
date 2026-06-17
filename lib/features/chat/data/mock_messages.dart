import '../models/message.dart';

final List<MessageModel> mockMessages = [
  MessageModel(
    id: '1',
    senderId: 6,
    receiverId: 1,
    text: 'Hello Doctor',
    timestamp: DateTime.now().subtract(
      const Duration(minutes: 30),
    ),
  ),
  MessageModel(
    id: '2',
    senderId: 1,
    receiverId: 6,
    text: 'Hello Ahmed, how can I help you?',
    timestamp: DateTime.now().subtract(
      const Duration(minutes: 28),
    ),
  ),
  MessageModel(
    id: '3',
    senderId: 6,
    receiverId: 1,
    text: 'I have been feeling anxious lately.',
    timestamp: DateTime.now().subtract(
      const Duration(minutes: 25),
    ),
  ),
  MessageModel(
    id: '4',
    senderId: 1,
    receiverId: 6,
    text: 'Can you tell me more about that?',
    timestamp: DateTime.now().subtract(
      const Duration(minutes: 20),
    ),
  ),
  MessageModel(
    id: '5',
    senderId: 6,
    receiverId: 1,
    text: 'Mostly before exams and presentations.',
    timestamp: DateTime.now().subtract(
      const Duration(minutes: 15),
    ),
  ),
  MessageModel(
    id: '6',
    senderId: 1,
    receiverId: 6,
    text: 'That is completely understandable.',
    timestamp: DateTime.now().subtract(
      const Duration(minutes: 12),
    ),
  ),
  MessageModel(
    id: '7',
    senderId: 6,
    receiverId: 1,
    text: 'Thank you doctor.',
    timestamp: DateTime.now().subtract(
      const Duration(minutes: 10),
    ),
  ),
];