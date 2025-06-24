part of use_cases;

final class FetchRecentMessagesUseCase
    implements StreamUseCase<List<ChatMessage>, ChatWithUserPayload> {
  final ChatRepository _chatRepository;

  const FetchRecentMessagesUseCase({
    required ChatRepository chatRepository,
  }) : _chatRepository = chatRepository;

  @override
  Stream<List<ChatMessage>> execute(ChatWithUserPayload input) {
    return _chatRepository.fetchRecentMessages(input);
  }
}
