import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_app/core/theme/app_colors.dart';
import 'package:prayer_app/core/theme/text_styles.dart';
import 'package:prayer_app/features/hadith/domain/hadith.dart';
import 'package:prayer_app/features/hadith/presentation/providers/hadith_providers.dart';
import 'package:prayer_app/features/hadith/presentation/screens/hadith_detail_screen.dart';

class HadithScreen extends ConsumerWidget {
  const HadithScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sections = ref.watch(hadithSectionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hadith - Sahih Bukhari'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.backgroundDark, AppColors.backgroundLight],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: sections.length,
          itemBuilder: (context, index) {
            final section = sections[index];
            return _SectionCard(
              section: section,
              onTap: () => _navigateToDetail(context, section),
            );
          },
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, HadithSection section) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HadithDetailScreen(section: section),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final HadithSection section;
  final VoidCallback onTap;

  const _SectionCard({
    required this.section,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryDark.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.auto_stories,
                  color: AppColors.primaryDark,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),

              // Section Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section.title,
                      style: TextStyles.heading3.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${section.totalHadiths} hadiths',
                      style: TextStyles.bodySmall.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
