part of use_cases;

final class FetchChatOverviewsUseCase
    implements StreamUseCase<List<ChatOverview>, ChatOverviewPayload> {
  final ChatRepository _chatRepository;

  const FetchChatOverviewsUseCase({
    required ChatRepository chatRepository,
  }) : _chatRepository = chatRepository;

  @override
  Stream<List<ChatOverview>> execute(ChatOverviewPayload input) {
    return _chatRepository.fetchChatOverviews(input);
  }
}
