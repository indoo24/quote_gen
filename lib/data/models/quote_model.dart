import '../../domain/entities/quote.dart';

/// Quote Model
/// Data layer representation of a Quote
class QuoteModel extends Quote {
  const QuoteModel({
    required super.text,
    required super.author,
    super.imageUrl,
  });

  /// Create QuoteModel from JSON
  /// Supports both internal format and quotable.io API format
  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      // quotable.io API uses 'content', internal format uses 'text'
      text: (json['content'] ?? json['text']) as String,
      author: json['author'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  /// Convert QuoteModel to JSON
  Map<String, dynamic> toJson() {
    return {'text': text, 'author': author, 'imageUrl': imageUrl};
  }

  /// Convert to domain entity
  Quote toEntity() {
    return Quote(text: text, author: author, imageUrl: imageUrl);
  }
}
