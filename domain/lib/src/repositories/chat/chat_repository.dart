part of repositories;

abstract interface class ChatRepository {
  Stream<List<ChatOverview>> fetchChatOverviews(ChatOverviewPayload payload);
  Future<void> sendMessage(ChatMessage message);
  Stream<List<ChatMessage>> fetchRecentMessages(ChatWithUserPayload payload);
  Future<List<ChatMessage>> fetchOldMessages(ChatWithUserPayload payload);
  Future<List<User>> fetchUsers(PaginationPayload<String> payload);
}
