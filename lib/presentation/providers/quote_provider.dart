import 'package:flutter/foundation.dart';
import '../../domain/entities/quote.dart';
import '../../domain/repositories/quote_repository.dart';

/// Quote Provider
/// Manages the state for quotes including favorites and daily quote
class QuoteProvider extends ChangeNotifier {
  final QuoteRepository _repository;

  QuoteProvider(this._repository);

  // Current daily quote
  Quote? _currentQuote;
  Quote? get currentQuote => _currentQuote;

  // Favorite quotes list
  final List<Quote> _favorites = [];
  List<Quote> get favorites => List.unmodifiable(_favorites);

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Error message
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Load the daily quote on app start
  Future<void> loadDailyQuote() async {
    _setLoading(true);
    _clearError();

    try {
      _currentQuote = await _repository.getDailyQuote();
      notifyListeners();
    } catch (e) {
      _setError('Failed to load quote: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Refresh to get a new random quote
  Future<void> refreshQuote() async {
    _setLoading(true);
    _clearError();

    try {
      _currentQuote = await _repository.getRandomQuote();
      notifyListeners();
    } catch (e) {
      _setError('Failed to refresh quote: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Toggle favorite status for a quote
  void toggleFavorite(Quote quote) {
    final index = _favorites.indexWhere((q) => q == quote);

    if (index >= 0) {
      // Remove from favorites
      _favorites.removeAt(index);
    } else {
      // Add to favorites
      _favorites.add(quote);
    }

    notifyListeners();
  }

  /// Check if a quote is favorited
  bool isFavorite(Quote quote) {
    return _favorites.any((q) => q == quote);
  }

  /// Remove a quote from favorites
  void removeFavorite(Quote quote) {
    _favorites.removeWhere((q) => q == quote);
    notifyListeners();
  }

  /// Helper methods
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}
