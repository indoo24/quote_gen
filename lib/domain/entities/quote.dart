/// Quote entity
/// Represents a motivational quote in the domain layer
class Quote {
  final String text;
  final String author;
  final String? imageUrl;

  const Quote({required this.text, required this.author, this.imageUrl});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Quote &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          author == other.author;

  @override
  int get hashCode => text.hashCode ^ author.hashCode;
}
