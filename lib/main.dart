import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/favorites_local_datasource.dart';
import 'data/repositories/api_quote_repository.dart';
import 'presentation/providers/quote_provider.dart';
import 'presentation/screens/main_navigation_screen.dart';

/// App entry point
void main() async {
  // Ensure Flutter bindings are initialized before using async operations
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences for local storage
  final prefs = await SharedPreferences.getInstance();

  runApp(QuoteGenApp(prefs: prefs));
}

/// Quote Generator Application
/// A motivational quote app with clean architecture
class QuoteGenApp extends StatelessWidget {
  final SharedPreferences prefs;

  const QuoteGenApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // QuoteProvider with dependency injection
        // Using ApiQuoteRepository to fetch real quotes from quotable.io API
        // Using FavoritesLocalDataSource to persist favorites locally
        // To switch back to mock data: Replace with MockQuoteRepository()
        ChangeNotifierProvider(
          create: (_) => QuoteProvider(
            ApiQuoteRepository(),
            localDataSource: FavoritesLocalDataSource(prefs),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Quote Generator',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const MainNavigationScreen(),
      ),
    );
  }
}
