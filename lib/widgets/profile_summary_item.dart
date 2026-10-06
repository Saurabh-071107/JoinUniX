import 'package:flutter/material.dart';

/// Reusable row component displaying a preference in the profile summary card.
class ProfileSummaryItem extends StatelessWidget {
  final Widget leading;
  final String label;

  const ProfileSummaryItem({
    super.key,
    required this.leading,
    required this.label,
  });

  factory ProfileSummaryItem.icon({
    Key? key,
    required IconData icon,
    required String label,
  }) {
    return ProfileSummaryItem(
      key: key,
      leading: Container(
        width: 38,
        height: 38,
        decoration: const BoxDecoration(
          color: Color(0xFFF1EBFF),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 20,
          color: const Color(0xFF6F2CFF),
        ),
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leading,
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1B2A56),
                letterSpacing: -0.2,
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
