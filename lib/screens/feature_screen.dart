import 'package:flutter/material.dart';
import '../data/features.dart';

void openFeature(BuildContext context, Feature f) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => FeatureScreen(feature: f)));

/// Hosts a single workflow with its own app bar.
class FeatureScreen extends StatelessWidget {
  final Feature feature;

  const FeatureScreen({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    final f = feature;
    if (f == Feature.consulAi || f == Feature.uniQuest || f == Feature.uniFinance) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: f.build(() => Navigator.maybePop(context)),
        ),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(12, 10, 16, 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.maybePop(context),
                        style: IconButton.styleFrom(backgroundColor: const Color(0xFFF1F5F9)),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: Color(0xFF1B2A56)),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: f.color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
                        child: Icon(f.icon, size: 18, color: f.color),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          f.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1B2A56), letterSpacing: -0.2),
                        ),
                      ),
                      if (f.ai) const AiBadge(),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    child: f.build(() => Navigator.maybePop(context)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AiBadge extends StatelessWidget {
  const AiBadge({super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(gradient: aiGradient, borderRadius: BorderRadius.circular(8)),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_awesome_rounded, size: 10, color: Colors.white),
            SizedBox(width: 3),
            Text('AI', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white)),
          ],
        ),
      );
}

const aiGradient = LinearGradient(
  colors: [Color(0xFF6F2CFF), Color(0xFF0F62FE)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
