import 'dart:math';
import '../../domain/entities/quote.dart';
import '../../domain/repositories/quote_repository.dart';
import '../models/quote_model.dart';

/// Mock Quote Repository Implementation
/// Provides hardcoded quotes for demonstration purposes
///
/// 🔄 TO REPLACE WITH REAL API:
/// 1. Create ApiQuoteRepository implementing QuoteRepository
/// 2. Use http package to fetch from quotes API
/// 3. Parse JSON response into QuoteModel
/// 4. Update main.dart to use ApiQuoteRepository instead of MockQuoteRepository
/// 5. Add error handling for network failures
class MockQuoteRepository implements QuoteRepository {
  final Random _random = Random();

  // Mock quotes database
  // In real implementation, this would come from API endpoint
  final List<QuoteModel> _quotes = const [
    QuoteModel(
      text: "The only way to do great work is to love what you do.",
      author: "STEVE JOBS",
      imageUrl: null,
    ),
    QuoteModel(
      text: "The only journey is the one within.",
      author: "RAINER MARIA RILKE",
      imageUrl: "assets/images/ocean.jpg",
    ),
    QuoteModel(
      text: "Nature does not hurry, yet everything is accomplished.",
      author: "LAO TZU",
      imageUrl: "assets/images/desert.jpg",
    ),
    QuoteModel(
      text: "Simplicity is the ultimate sophistication.",
      author: "LEONARDO DA VINCI",
      imageUrl: "assets/images/leaf.jpg",
    ),
    QuoteModel(
      text: "Be yourself; everyone else is already taken.",
      author: "OSCAR WILDE",
      imageUrl: null,
    ),
    QuoteModel(
      text: "In the middle of difficulty lies opportunity.",
      author: "ALBERT EINSTEIN",
      imageUrl: "assets/images/mountains.jpg",
    ),
    QuoteModel(
      text:
          "The best time to plant a tree was 20 years ago. The second best time is now.",
      author: "CHINESE PROVERB",
      imageUrl: null,
    ),
    QuoteModel(
      text: "Life is what happens when you're busy making other plans.",
      author: "JOHN LENNON",
      imageUrl: "assets/images/sunset.jpg",
    ),
    QuoteModel(
      text: "The journey of a thousand miles begins with one step.",
      author: "LAO TZU",
      imageUrl: null,
    ),
    QuoteModel(
      text: "What we think, we become.",
      author: "BUDDHA",
      imageUrl: "assets/images/meditation.jpg",
    ),
  ];

  @override
  Future<Quote> getDailyQuote() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    // Return the first quote as "daily quote"
    // API equivalent: GET /api/quotes/daily
    return _quotes[0];
  }

  @override
  Future<Quote> getRandomQuote() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    // Return a random quote
    // API equivalent: GET /api/quotes/random
    final index = _random.nextInt(_quotes.length);
    return _quotes[index];
  }
}
