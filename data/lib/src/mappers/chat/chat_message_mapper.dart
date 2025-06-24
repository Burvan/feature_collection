part of mappers;

final class ChatMessageMapper
    extends Mapper<ChatMessageEntity, domain.ChatMessage> {
  @override
  domain.ChatMessage fromEntity(ChatMessageEntity entity) {
    return domain.ChatMessage(
      id: entity.id,
      senderId: entity.senderId,
      receiverId: entity.receiverId,
      text: entity.text,
      timestamp: entity.timestamp,
    );
  }

  @override
  ChatMessageEntity toEntity(domain.ChatMessage item) {
    return ChatMessageEntity(
      id: item.id,
      senderId: item.senderId,
      receiverId: item.receiverId,
      text: item.text,
      timestamp: item.timestamp,
    );
  }
}
