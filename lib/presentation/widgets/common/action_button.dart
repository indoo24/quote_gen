import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// Action Button Widget
/// Circular button with icon and label (used for Favorite, Refresh, Share)
class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isActive;
  final bool isPrimary;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isActive = false,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Circular button
        Material(
          color: isPrimary ? AppTheme.primaryColor : AppTheme.cardColor,
          elevation: isPrimary ? 4 : 0,
          shadowColor: AppTheme.shadowColor,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            child: Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: isPrimary
                    ? Colors.white
                    : isActive
                    ? AppTheme.iconActiveColor
                    : AppTheme.iconColor,
                size: isPrimary
                    ? AppTheme.iconSizeLarge
                    : AppTheme.iconSizeMedium,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Label
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: isPrimary ? AppTheme.primaryColor : AppTheme.textSecondary,
            fontWeight: isPrimary ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
