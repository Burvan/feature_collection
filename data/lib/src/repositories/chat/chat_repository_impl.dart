part of repositories;

final class ChatRepositoryImpl implements ChatRepository {
  final FirebaseProvider _firebaseProvider;

  ChatRepositoryImpl({
    required FirebaseProvider firebaseProvider,
  }) : _firebaseProvider = firebaseProvider;

  @override
  Stream<List<ChatMessage>> fetchRecentMessages(ChatWithUserPayload payload) {
    return _firebaseProvider.fetchRecentMessages(payload).map(
      (List<ChatMessageEntity> entities) {
        return entities
            .map((ChatMessageEntity entity) =>
                MapperFactory.chatMessageMapper.fromEntity(entity))
            .toList();
      },
    );
  }

  @override
  Future<List<ChatMessage>> fetchOldMessages(
      ChatWithUserPayload payload) async {
    final List<ChatMessageEntity> entities =
        await _firebaseProvider.fetchOldMessages(payload);

    return entities
        .map((ChatMessageEntity entity) =>
            MapperFactory.chatMessageMapper.fromEntity(entity))
        .toList();
  }

  @override
  Stream<List<ChatOverview>> fetchChatOverviews(ChatOverviewPayload payload) {
    return _firebaseProvider.fetchChatOverviews(payload).map(
      (List<ChatOverviewEntity> entities) {
        return entities
            .map((ChatOverviewEntity entity) =>
                MapperFactory.chatOverviewMapper.fromEntity(entity))
            .toList();
      },
    );
  }

  @override
  Future<void> sendMessage(ChatMessage message) async {
    final ChatMessageEntity entity =
        MapperFactory.chatMessageMapper.toEntity(message);
    await _firebaseProvider.sendMessage(entity);
  }

  @override
  Future<List<User>> fetchUsers(PaginationPayload<String> payload) async {
    final List<UserEntity> entities =
        await _firebaseProvider.fetchUsers(payload);

    return entities
        .map((UserEntity entity) => MapperFactory.userMapper.fromEntity(entity))
        .toList();
  }
}
