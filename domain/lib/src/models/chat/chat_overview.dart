part of models;

final class ChatOverview {
  final String userId;
  final String fullName;
  final String? avatarUrl;
  final String? lastMessage;
  final DateTime? lastMessageTime;

  const ChatOverview({
    required this.userId,
    required this.fullName,
    this.avatarUrl,
    this.lastMessage,
    this.lastMessageTime,
  });
}
