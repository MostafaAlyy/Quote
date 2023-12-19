import 'package:quotes/features/categories/domain/entities/quote_category.dart';

class QuoteCategoryModel extends QuoteCategory {
  QuoteCategoryModel({
    required super.id,
    required super.name,
    required super.dateAdded,
    required super.dateModified,
    required super.quoteCount,
    required super.slug,
  });

  factory QuoteCategoryModel.fromJson(Map<String, dynamic> json) =>
      QuoteCategoryModel(
        id: json["_id"],
        name: json["name"],
        slug: json["slug"],
        quoteCount: json["quoteCount"],
        dateAdded: DateTime.parse(json["dateAdded"]),
        dateModified: DateTime.parse(json["dateModified"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "slug": slug,
        "quoteCount": quoteCount,
        "dateAdded":
            "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
        "dateModified":
            "${dateModified.year.toString().padLeft(4, '0')}-${dateModified.month.toString().padLeft(2, '0')}-${dateModified.day.toString().padLeft(2, '0')}",
      };
}
