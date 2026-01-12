import 'package:flutter/foundation.dart';
import '../../domain/entities/quote.dart';
import '../../domain/repositories/quote_repository.dart';
import '../../data/datasources/favorites_local_datasource.dart';

/// QuoteProvider
/// Manages quotes state, favorites, loading and error handling
/// Integrates with local storage to persist favorites between app sessions
class QuoteProvider extends ChangeNotifier {
  final QuoteRepository _repository;
  final FavoritesLocalDataSource? _localDataSource;

  QuoteProvider(this._repository, {FavoritesLocalDataSource? localDataSource})
      : _localDataSource = localDataSource {
    // Load cached favorites on initialization
    _loadCachedFavorites();
  }

  // Current quote
  Quote? _currentQuote;
  Quote? get currentQuote => _currentQuote;

  // Favorites
  final List<Quote> _favorites = [];
  List<Quote> get favorites => List.unmodifiable(_favorites);

  // Loading & error states
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Prevent multiple rapid API calls (rate-limit protection)
  bool _isFetching = false;

  /// Load daily quote (called on app start)
  Future<void> loadDailyQuote() async {
    if (_isFetching) return;

    _startLoading();

    try {
      _currentQuote = await _repository.getDailyQuote();
      _clearError();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _stopLoading();
    }
  }

  /// Fetch a new random quote
  Future<void> refreshQuote() async {
    if (_isFetching) return;

    _startLoading();

    try {
      _currentQuote = await _repository.getRandomQuote();
      _clearError();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _stopLoading();
    }
  }

  /// Favorites handling
  void toggleFavorite(Quote quote) {
    final exists = _favorites.any((q) => q == quote);

    if (exists) {
      _favorites.removeWhere((q) => q == quote);
    } else {
      _favorites.add(quote);
    }

    // Save to local storage
    _saveFavoritesToCache();

    notifyListeners();
  }

  bool isFavorite(Quote quote) {
    return _favorites.any((q) => q == quote);
  }

  void removeFavorite(Quote quote) {
    _favorites.removeWhere((q) => q == quote);
    
    // Save to local storage
    _saveFavoritesToCache();
    
    notifyListeners();
  }

  /// Private helpers

  /// Load cached favorites from local storage on initialization
  void _loadCachedFavorites() {
    if (_localDataSource == null) return;

    try {
      final cachedFavorites = _localDataSource.loadFavorites();
      _favorites.clear();
      _favorites.addAll(cachedFavorites);
      
      // No need to notify listeners here - this runs before UI is built
    } catch (e) {
      // Fail silently - app continues with empty favorites if cache fails
    }
  }

  /// Save current favorites to local storage
  Future<void> _saveFavoritesToCache() async {
    if (_localDataSource == null) return;

    try {
      await _localDataSource.saveFavorites(_favorites);
    } catch (e) {
      // Fail silently - don't interrupt user experience if caching fails
    }
  }

  void _startLoading() {
    _isFetching = true;
    _isLoading = true;
    notifyListeners();
  }

  void _stopLoading() {
    _isFetching = false;
    _isLoading = false;
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
