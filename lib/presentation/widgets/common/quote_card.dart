import 'package:flutter/material.dart';
import '../../../domain/entities/quote.dart';
import '../../../core/theme/app_theme.dart';

/// Quote Card Widget
/// Displays a quote with author in a card with optional background image
class QuoteCard extends StatelessWidget {
  final Quote quote;
  final VoidCallback? onFavorite;
  final VoidCallback? onShare;
  final bool isFavorite;
  final bool showActions;

  const QuoteCard({
    super.key,
    required this.quote,
    this.onFavorite,
    this.onShare,
    this.isFavorite = false,
    this.showActions = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: AppTheme.shadowColor,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 400),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          image: quote.imageUrl != null
              ? DecorationImage(
                  image: AssetImage(quote.imageUrl!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.85),
                    BlendMode.lighten,
                  ),
                )
              : null,
          color: AppTheme.cardColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.paddingXLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Opening quote mark
              const Icon(
                Icons.format_quote,
                size: 48,
                color: Color(0xFFE0E0E0),
              ),
              const SizedBox(height: AppTheme.paddingLarge),

              // Quote text
              Text(
                '"${quote.text}"',
                style: AppTheme.quoteStyle,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: AppTheme.paddingLarge),

              // Divider line
              Container(
                width: 50,
                height: 3,
                decoration: BoxDecoration(
                  color: AppTheme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: AppTheme.paddingMedium),

              // Author name
              Text(quote.author, style: AppTheme.authorStyle),

              // Closing quote mark
              const SizedBox(height: AppTheme.paddingLarge),
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.format_quote,
                  size: 48,
                  color: const Color(0xFFE0E0E0),
                ),
              ),

              // Action buttons (if shown on favorites page)
              if (showActions) ...[
                const SizedBox(height: AppTheme.paddingMedium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (onShare != null)
                      IconButton(
                        icon: const Icon(Icons.share_outlined),
                        onPressed: onShare,
                        color: AppTheme.iconColor,
                      ),
                    if (onFavorite != null)
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                        ),
                        onPressed: onFavorite,
                        color: isFavorite
                            ? AppTheme.iconActiveColor
                            : AppTheme.iconColor,
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
