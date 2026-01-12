import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/api_quote_repository.dart';
import 'presentation/providers/quote_provider.dart';
import 'presentation/screens/main_navigation_screen.dart';

/// App entry point
void main() {
  runApp(const QuoteGenApp());
}

/// Quote Generator Application
/// A motivational quote app with clean architecture
class QuoteGenApp extends StatelessWidget {
  const QuoteGenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // QuoteProvider with dependency injection
        // Using ApiQuoteRepository to fetch real quotes from quotable.io API
        // To switch back to mock data: Replace with MockQuoteRepository()
        ChangeNotifierProvider(
          create: (_) => QuoteProvider(ApiQuoteRepository()),
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
