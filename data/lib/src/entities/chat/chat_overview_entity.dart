import 'package:core/core.dart';

final class ChatOverviewEntity {
  final String id;
  final String fullName;
  final String? avatar;
  final String? lastMessage;
  final DateTime? lastMessageTimeKey;

  const ChatOverviewEntity({
    required this.id,
    required this.fullName,
    this.avatar,
    this.lastMessage,
    this.lastMessageTimeKey,
  });

  factory ChatOverviewEntity.fromJson(Map<String, dynamic> json) {
    final dynamic timestamp = json['lastMessageTimeKey'];
    return ChatOverviewEntity(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      avatar: json['avatar'] as String?,
      lastMessage: json['lastMessage'] as String?,
      lastMessageTimeKey: timestamp is Timestamp ? timestamp.toDate() : null,
    );
  }
}
