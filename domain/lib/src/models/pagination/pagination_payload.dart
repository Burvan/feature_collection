part of models;

final class PaginationPayload<T> {
  final int limit;
  final T? paginationCursor;
  final String? query;

  const PaginationPayload({
    required this.limit,
    this.paginationCursor,
    this.query,
  });

  const PaginationPayload.initial({
    this.paginationCursor,
    this.query,
  }) : limit = 20;
}
