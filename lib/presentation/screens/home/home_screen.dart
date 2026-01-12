import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/quote.dart';
import '../../providers/quote_provider.dart';
import '../../widgets/common/quote_card.dart';
import '../../widgets/common/action_button.dart';

/// Home Screen
/// Displays the daily quote with actions: favorite, refresh, share
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load daily quote on screen initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuoteProvider>().loadDailyQuote();
    });
  }

  /// Get time of day greeting
  String _getTimeOfDay() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'MORNING';
    } else if (hour < 17) {
      return 'AFTERNOON';
    } else {
      return 'EVENING';
    }
  }

  /// Handle share action
  void _handleShare(Quote quote) {
    final shareText = '"${quote.text}"\n\n— ${quote.author}';
    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: AppTheme.paddingMedium),
          child: Text(_getTimeOfDay(), style: AppTheme.timeOfDayStyle),
        ),
        leadingWidth: 120,
        title: const Text('DAILY QUOTE'),
        actions: [
          // Notification bell (placeholder for future functionality)
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications coming soon!')),
              );
            },
          ),
        ],
      ),
      body: Consumer<QuoteProvider>(
        builder: (context, provider, child) {
          // Loading state
          if (provider.isLoading && provider.currentQuote == null) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error state
          if (provider.errorMessage != null && provider.currentQuote == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppTheme.textSecondary,
                  ),
                  const SizedBox(height: AppTheme.paddingMedium),
                  Text(
                    'Oops! Something went wrong',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppTheme.paddingSmall),
                  Text(
                    provider.errorMessage!,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppTheme.paddingLarge),
                  ElevatedButton(
                    onPressed: () => provider.loadDailyQuote(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final quote = provider.currentQuote;
          if (quote == null) {
            return const SizedBox.shrink();
          }

          final isFavorite = provider.isFavorite(quote);

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.paddingLarge),
                child: Column(
                  children: [
                    // Quote Card
                    QuoteCard(quote: quote),
                    const SizedBox(height: AppTheme.paddingXLarge),

                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Favorite Button
                        ActionButton(
                          icon: isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          label: 'FAVORITE',
                          isActive: isFavorite,
                          onPressed: () => provider.toggleFavorite(quote),
                        ),

                        // Refresh Button (Primary)
                        ActionButton(
                          icon: Icons.refresh,
                          label: 'REFRESH',
                          isPrimary: true,
                          onPressed: () => provider.refreshQuote(),
                        ),

                        // Share Button
                        ActionButton(
                          icon: Icons.share_outlined,
                          label: 'SHARE',
                          onPressed: () => _handleShare(quote),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
