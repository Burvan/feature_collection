part of models;

final class ChatWithUserPayload {
  final String currentUserId;
  final String otherUserId;
  final PaginationPayload paginationPayload;

  const ChatWithUserPayload({
    required this.currentUserId,
    required this.otherUserId,
    required this.paginationPayload,
  });
}
