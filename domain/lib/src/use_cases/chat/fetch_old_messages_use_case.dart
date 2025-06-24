part of use_cases;

final class FetchOldMessagesUseCase
    extends FutureUseCase<List<ChatMessage>, ChatWithUserPayload> {
  final ChatRepository _chatRepository;

  FetchOldMessagesUseCase({
    required ChatRepository chatRepository,
  }) : _chatRepository = chatRepository;

  @override
  Future<List<ChatMessage>> execute(ChatWithUserPayload input) async {
    return _chatRepository.fetchOldMessages(input);
  }
}
