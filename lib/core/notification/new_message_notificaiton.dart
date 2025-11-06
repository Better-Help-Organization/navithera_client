// lib/presentation/widgets/new_message_notification_banner.dart (example path)
import 'package:flutter/material.dart';
import 'package:navithera_client/core/theme/app_colors.dart';

class NewMessageNotificationBanner extends StatelessWidget {
  final String title;
  final String body;
  final VoidCallback? onTap;
  final bool isMessage; // Function to call when tapped

  const NewMessageNotificationBanner({
    Key? key,
    required this.title,
    required this.body,
    this.onTap,
    this.isMessage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Wrap with Material for proper theme application (text styles, etc.)
    // and GestureDetector for tap handling
    return Material(
      color: Colors.transparent, // Makes the Material widget itself invisible
      child: SafeArea(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ), // Add some margin
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: AppColors.primary, // Use theme colors
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                if (isMessage) ...[
                  Icon(
                    Icons.chat_bubble_outline, // Chat icon
                    color: Colors.white,
                  ),
                ] else ...[
                  Icon(
                    Icons.notifications_none, // Notification icon
                    color: Colors.white,
                  ),
                ],
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Important for content not to overflow the overlay
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        body,
                        style: TextStyle(color: Colors.white),
                        maxLines: 2, // Show a preview
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(
                  // Optional: chevron or indicator
                  Icons.chevron_right,
                  color: Theme.of(
                    context,
                  ).colorScheme.onPrimaryContainer.withOpacity(0.6),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
