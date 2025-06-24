part of models;

final class ChatMessage {
  final String? id;
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime timestamp;

  const ChatMessage({
    this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timestamp,
  });
}
