part of models;

final class FetchCharactersParams {
  final int limit;
  final String? paginationCursor;
  final String? query;

  const FetchCharactersParams({
    this.limit = 10,
    this.paginationCursor,
    this.query,
  });
}
