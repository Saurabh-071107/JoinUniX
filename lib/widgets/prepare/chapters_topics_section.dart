import 'package:flutter/material.dart';
import '../../data/prepare_data.dart';

class ChaptersTopicsSection extends StatelessWidget {
  final VoidCallback? onViewAll;
  final ValueChanged<SubjectChapterGroup>? onSubjectTap;

  const ChaptersTopicsSection({
    super.key,
    this.onViewAll,
    this.onSubjectTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Chapters & Topics',
                style: TextStyle(
                  fontSize: 18.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
              ),
              InkWell(
                onTap: onViewAll,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4F46E5),
                        ),
                      ),
                      SizedBox(width: 3),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 14,
                        color: Color(0xFF4F46E5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Horizontal List of 3 Subject Cards
        SizedBox(
          height: 248,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: subjectChapterGroups.length,
            separatorBuilder: (_, _) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final group = subjectChapterGroups[index];
              return _buildSubjectCard(group);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSubjectCard(SubjectChapterGroup group) {
    return GestureDetector(
      onTap: () => onSubjectTap?.call(group),
      child: Container(
        width: 256,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: group.bgColor,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: group.borderColor, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: group.accentColor.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Header: Icon + Subject Name + Chevron Button
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: group.borderColor),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    group.iconPath,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => Icon(Icons.menu_book, color: group.accentColor),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.subject,
                        style: const TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        group.chaptersCountText,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: group.accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 5,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Mini Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: group.progress,
                minHeight: 5,
                backgroundColor: Colors.white.withValues(alpha: 0.8),
                valueColor: AlwaysStoppedAnimation<Color>(group.accentColor),
              ),
            ),
            const SizedBox(height: 12),

            // Topics list
            ...group.topics.map((topic) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.5),
                child: Row(
                  children: [
                    _buildTopicStatusIcon(topic.status),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        topic.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: topic.status == TopicStatus.inProgress
                              ? FontWeight.w700
                              : (topic.status == TopicStatus.completed
                                  ? FontWeight.w600
                                  : FontWeight.w500),
                          color: topic.status == TopicStatus.inProgress
                              ? const Color(0xFF0F172A)
                              : const Color(0xFF334155),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicStatusIcon(TopicStatus status) {
    switch (status) {
      case TopicStatus.completed:
        return const Icon(
          Icons.check_circle_rounded,
          size: 18,
          color: Color(0xFF10B981),
        );
      case TopicStatus.inProgress:
        return const Icon(
          Icons.play_circle_fill_rounded,
          size: 18,
          color: Color(0xFF6366F1),
        );
      case TopicStatus.notStarted:
        return Container(
          width: 17,
          height: 17,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFCBD5E1), width: 1.8),
          ),
        );
    }
  }
}
