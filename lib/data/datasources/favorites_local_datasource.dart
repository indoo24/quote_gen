import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/quote.dart';
import '../models/quote_model.dart';

/// FavoritesLocalDataSource
/// Handles local storage of favorite quotes using SharedPreferences
/// 
/// Responsibilities:
/// - Save favorites to local storage as JSON
/// - Load favorites from local storage on app start
/// - Clear favorites if needed
/// 
/// Storage format: List of Map (String to dynamic) stored as JSON string
class FavoritesLocalDataSource {
  static const String _favoritesKey = 'favorite_quotes';

  final SharedPreferences _prefs;

  FavoritesLocalDataSource(this._prefs);

  /// Save a list of favorite quotes to local storage
  /// Converts Quote entities to JSON-serializable maps
  /// 
  /// Returns true if save was successful, false otherwise
  Future<bool> saveFavorites(List<Quote> favorites) async {
    try {
      // Convert Quote entities to QuoteModel for JSON serialization
      final List<Map<String, dynamic>> jsonList = favorites
          .map((quote) => QuoteModel(
                text: quote.text,
                author: quote.author,
                imageUrl: quote.imageUrl,
              ).toJson())
          .toList();

      // Encode to JSON string
      final String jsonString = jsonEncode(jsonList);

      // Save to SharedPreferences
      return await _prefs.setString(_favoritesKey, jsonString);
    } catch (e) {
      // Fail silently - don't crash the app if caching fails
      return false;
    }
  }

  /// Load favorite quotes from local storage
  /// Converts JSON data back to Quote entities
  /// 
  /// Returns list of quotes, or empty list if:
  /// - No cached data exists
  /// - Cache is corrupted
  /// - Any error occurs during loading
  List<Quote> loadFavorites() {
    try {
      // Get JSON string from SharedPreferences
      final String? jsonString = _prefs.getString(_favoritesKey);

      // Return empty list if no cached data
      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      // Decode JSON string to list
      final List<dynamic> jsonList = jsonDecode(jsonString);

      // Convert each JSON map to Quote entity
      final List<Quote> favorites = jsonList
          .map((json) => QuoteModel.fromJson(json as Map<String, dynamic>).toEntity())
          .toList();

      return favorites;
    } catch (e) {
      // Fail silently - return empty list if cache is corrupted
      // This prevents app crashes due to malformed cached data
      return [];
    }
  }

  /// Clear all favorite quotes from local storage
  /// 
  /// Returns true if clear was successful, false otherwise
  Future<bool> clearFavorites() async {
    try {
      return await _prefs.remove(_favoritesKey);
    } catch (e) {
      return false;
    }
  }
}
