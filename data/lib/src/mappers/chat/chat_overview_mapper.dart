part of mappers;

final class ChatOverviewMapper
    extends Mapper<ChatOverviewEntity, domain.ChatOverview> {
  @override
  domain.ChatOverview fromEntity(ChatOverviewEntity entity) {
    return domain.ChatOverview(
      userId: entity.id,
      fullName: entity.fullName,
      avatarUrl: entity.avatar,
      lastMessage: entity.lastMessage,
      lastMessageTime: entity.lastMessageTimeKey,
    );
  }

  @override
  ChatOverviewEntity toEntity(domain.ChatOverview item) {
    return ChatOverviewEntity(
      id: item.userId,
      fullName: item.fullName,
      avatar: item.avatarUrl,
      lastMessage: item.lastMessage,
      lastMessageTimeKey: item.lastMessageTime,
    );
  }
}
