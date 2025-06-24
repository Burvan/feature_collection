import 'package:core/core.dart';

part 'chat_message_entity.g.dart';

@JsonSerializable()
final class ChatMessageEntity {
  final String? id;
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime timestamp;

  const ChatMessageEntity({
    this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timestamp,
  });

  factory ChatMessageEntity.fromJson(Map<String, dynamic> json) {
    return _$ChatMessageEntityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChatMessageEntityToJson(this);
}
