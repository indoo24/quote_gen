import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/quote.dart';
import '../../providers/quote_provider.dart';
import '../../widgets/common/quote_card.dart';

/// Favorites Screen
/// Displays all favorited quotes in a scrollable list
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
        title: const Text('Favorites'),
        centerTitle: true,
        automaticallyImplyLeading:
            false, // Remove back button (this is a main tab)
      ),
      body: Consumer<QuoteProvider>(
        builder: (context, provider, child) {
          final favorites = provider.favorites;

          // Empty state
          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: AppTheme.textSecondary.withOpacity(0.3),
                  ),
                  const SizedBox(height: AppTheme.paddingLarge),
                  Text(
                    'YOUR COLLECTION',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppTheme.textSecondary.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: AppTheme.paddingSmall),
                  Text(
                    'No favorites yet',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.paddingSmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.paddingXLarge,
                    ),
                    child: Text(
                      'Start adding quotes to your collection by tapping the heart icon',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          }

          // List of favorites
          return CustomScrollView(
            slivers: [
              // Section header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.paddingLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'YOUR COLLECTION',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(height: AppTheme.paddingSmall),
                      Text(
                        '${favorites.length} ${favorites.length == 1 ? 'quote' : 'quotes'} saved',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),

              // Favorites list
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.paddingLarge,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final quote = favorites[index];
                    final isFavorite = provider.isFavorite(quote);

                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppTheme.paddingLarge,
                      ),
                      child: QuoteCard(
                        quote: quote,
                        isFavorite: isFavorite,
                        showActions: true,
                        onFavorite: () => provider.toggleFavorite(quote),
                        onShare: () => _handleShare(quote),
                      ),
                    );
                  }, childCount: favorites.length),
                ),
              ),

              // Bottom padding
              const SliverToBoxAdapter(
                child: SizedBox(height: AppTheme.paddingLarge),
              ),
            ],
          );
        },
      ),
    );
  }
}
