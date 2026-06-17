class ChatUser {
  final int id;
  final String name;
  final String role;
  final String? imageUrl;
  final bool isOnline;

  ChatUser({
    required this.id,
    required this.name,
    required this.role,
    this.imageUrl,
    this.isOnline = false,
  });
}