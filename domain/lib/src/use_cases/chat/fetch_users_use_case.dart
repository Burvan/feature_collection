part of use_cases;

final class FetchUsersUseCase
    implements FutureUseCase<List<User>, PaginationPayload<String>> {
  final ChatRepository _chatRepository;

  const FetchUsersUseCase({
    required ChatRepository chatRepository,
  }) : _chatRepository = chatRepository;

  @override
  Future<List<User>> execute(PaginationPayload<String> input) {
    return _chatRepository.fetchUsers(input);
  }
}
