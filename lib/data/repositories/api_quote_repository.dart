import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../domain/entities/quote.dart';
import '../../domain/repositories/quote_repository.dart';
import '../models/quote_model.dart';

/// API Quote Repository Implementation
/// Fetches real quotes from quotable.io API
///
/// Architecture:
/// - Implements QuoteRepository interface (domain layer contract)
/// - Uses http package for network calls (data layer responsibility)
/// - Converts API response to QuoteModel, then to Quote entity
/// - Handles errors gracefully without exposing implementation details
class ApiQuoteRepository implements QuoteRepository {
  final http.Client _httpClient;

  // API endpoint for random quotes
  static const String _baseUrl = 'https://zenquotes.io';
  static const String _randomEndpoint = '/api/random';

  /// Constructor with dependency injection
  /// Allows for easy testing by injecting mock http client
  ApiQuoteRepository({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  @override
  Future<Quote> getDailyQuote() async {
    // For daily quote, we'll fetch a random quote
    // In a production app, this could be cached or use a specific endpoint
    return getRandomQuote();
  }

  @override
  Future<Quote> getRandomQuote() async {
    try {
      // Make HTTP GET request to quotable.io API
      final response = await _httpClient
          .get(Uri.parse('$_baseUrl$_randomEndpoint'))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception(
                'Request timeout. Please check your internet connection.',
              );
            },
          );

      // Check if request was successful
      if (response.statusCode == 200) {
        // Parse JSON response
        final List<dynamic> jsonList = json.decode(response.body);
        final Map<String, dynamic> jsonData = jsonList.first;

        final quoteModel = QuoteModel(
          text: jsonData['q'] as String,
          author: jsonData['a'] as String,
        );

        // Return as domain entity
        // QuoteModel extends Quote, so it's already a Quote entity
        return quoteModel;
      } else if (response.statusCode == 404) {
        throw Exception('Quote not found. Please try again.');
      } else if (response.statusCode >= 500) {
        throw Exception('Server error. Please try again later.');
      } else if (response.statusCode == 429) {
        throw Exception(
          'You are requesting quotes too frequently. Please wait a moment and try again.',
        );
      } else {
        throw Exception(
          'Failed to load quote. Status code: ${response.statusCode}',
        );
      }
    } on SocketException {
      // No internet connection or DNS resolution failed
      throw Exception(
        'No internet connection. Please check your network settings.',
      );
    } on HandshakeException {
      // SSL/TLS handshake error (certificate issues)
      throw Exception(
        'Secure connection failed. Please check your internet connection and try again.',
      );
    } on http.ClientException {
      // Other network-related errors (connection refused, etc.)
      throw Exception('Network error. Please check your internet connection.');
    } on FormatException {
      // JSON parsing errors
      throw Exception('Invalid data received. Please try again.');
    } catch (e) {
      // Catch any other unexpected errors
      // Re-throw if it's already an Exception we created
      if (e is Exception) {
        rethrow;
      }
      // Otherwise, wrap in a generic error message
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }

  /// Clean up resources when repository is no longer needed
  void dispose() {
    _httpClient.close();
  }
}
