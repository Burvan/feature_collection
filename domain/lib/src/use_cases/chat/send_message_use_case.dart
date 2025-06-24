part of use_cases;

final class SendMessageUseCase implements FutureUseCase<void, ChatMessage> {
  final ChatRepository _chatRepository;

  const SendMessageUseCase({
    required ChatRepository chatRepository,
  }) : _chatRepository = chatRepository;

  @override
  Future<void> execute(ChatMessage input) async {
    await _chatRepository.sendMessage(input);
  }
}
