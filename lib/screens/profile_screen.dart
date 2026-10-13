import 'package:flutter/material.dart';
import '../data/profile_data.dart';
import '../widgets/profile/profile_header_card.dart';
import '../widgets/profile/profile_progress_card.dart';
import '../widgets/profile/profile_stats_grid.dart';
import '../widgets/profile/profile_menu_card.dart';
import '../widgets/profile/profile_logout_button.dart';

class ProfileScreen extends StatelessWidget {
  final UserProfileModel user;
  final Function(String message)? onAction;

  const ProfileScreen({
    super.key,
    this.user = defaultUserProfile,
    this.onAction,
  });

  void _notify(BuildContext context, String message) {
    if (onAction != null) {
      onAction!(message);
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // 1. Panoramic Header & Profile Card
                SliverToBoxAdapter(
                  child: ProfileHeaderCard(
                    user: user,
                    onAvatarTap: () => _notify(context, 'Change Profile Photo'),
                    onEditTap: () => _notify(context, 'Edit Profile Details'),
                  ),
                ),

                // 2. Preparation Progress Ring Card
                SliverToBoxAdapter(
                  child: ProfileProgressCard(
                    progress: user.preparationProgress,
                    onViewDetails: () => _notify(context, 'Viewing Detailed Progress'),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 14)),

                // 3. Stats Grid (Tests, Best Score, Friends, Opportunities)
                SliverToBoxAdapter(
                  child: ProfileStatsGrid(
                    onStatTap: (stat) => _notify(context, '${stat.label}: ${stat.value}'),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 14)),

                // 4. Menu Settings Options Card
                SliverToBoxAdapter(
                  child: ProfileMenuCard(
                    onMenuItemTap: (item) => _notify(context, 'Opening ${item.title}'),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 14)),

                // 5. Logout Button
                SliverToBoxAdapter(
                  child: ProfileLogoutButton(
                    onLogoutTap: () => _notify(context, 'Logging out...'),
                  ),
                ),

                // Bottom Padding for floating navigation bar
                const SliverToBoxAdapter(
                  child: SizedBox(height: 108),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
