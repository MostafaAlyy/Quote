import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  final String id;
  final String content;
  final String author;
  final List<String> tags;
  final String authorSlug;
  final int length;
  final DateTime dateAdded;
  final DateTime dateModified;

  const Quote({
    required this.author,
    required this.authorSlug,
    required this.content,
    required this.dateAdded,
    required this.dateModified,
    required this.id,
    required this.length,
    required this.tags,
  });

  @override
  List<Object> get props => [id];
}
