part of models;

final class FetchCharactersParams {
  final int limit;
  final String? paginationCursor;
  final String? query;

  const FetchCharactersParams({
    required this.limit,
    this.paginationCursor,
    this.query,
  });

  const FetchCharactersParams.initial({
    this.paginationCursor,
    this.query,
  }) : limit = 10;
}
