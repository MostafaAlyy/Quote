class QuoteCategory {
  final String id;
  final String name;
  final String slug;
  final int quoteCount;
  final DateTime dateAdded;
  final DateTime dateModified;

  QuoteCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.quoteCount,
    required this.dateAdded,
    required this.dateModified,
  });
}
