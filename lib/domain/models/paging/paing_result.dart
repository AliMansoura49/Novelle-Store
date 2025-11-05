class PagingResult<T> {
  final List<T> items;
  final bool hasMore;

  const PagingResult(this.items, {required this.hasMore});
}