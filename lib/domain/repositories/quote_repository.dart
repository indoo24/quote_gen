import '../entities/quote.dart';

/// Quote Repository Interface
/// Defines the contract for fetching quotes
abstract class QuoteRepository {
  /// Get a random daily quote
  Future<Quote> getDailyQuote();

  /// Get a new random quote (for refresh action)
  Future<Quote> getRandomQuote();
}
