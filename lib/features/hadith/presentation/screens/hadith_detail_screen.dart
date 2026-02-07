import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_app/core/theme/app_colors.dart';
import 'package:prayer_app/core/theme/text_styles.dart';
import 'package:prayer_app/features/hadith/data/hadith_repository.dart';
import 'package:prayer_app/features/hadith/domain/hadith.dart';
import 'package:prayer_app/features/hadith/presentation/providers/hadith_providers.dart';

class HadithDetailScreen extends ConsumerWidget {
  final HadithSection section;

  const HadithDetailScreen({
    super.key,
    required this.section,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hadiths = ref.watch(hadithsForSectionProvider(section));
    final selectedLanguage = ref.watch(selectedLanguageProvider);
    final repository = ref.watch(hadithRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(section.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => _showLanguageDialog(context, ref, repository),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.backgroundDark, AppColors.backgroundLight],
          ),
        ),
        child: Column(
          children: [
            // Language Indicator
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Language: ${repository.getLanguageName(selectedLanguage)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Hadiths List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: hadiths.length,
                itemBuilder: (context, index) {
                  final hadith = hadiths[index];
                  return _HadithCard(hadith: hadith);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(
    BuildContext context,
    WidgetRef ref,
    HadithRepository repository,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Language',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...HadithLanguage.values.map((lang) {
              return ListTile(
                title: Text(repository.getLanguageName(lang)),
                trailing: ref.watch(selectedLanguageProvider) == lang
                    ? const Icon(Icons.check, color: AppColors.primaryDark)
                    : null,
                onTap: () {
                  ref.read(selectedLanguageProvider.notifier).state = lang;
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _HadithCard extends StatelessWidget {
  final Hadith hadith;

  const _HadithCard({required this.hadith});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hadith Number
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryDark.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Hadith ${hadith.hadithnumber}',
                style: TextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Hadith Text
            Text(
              hadith.text,
              style: TextStyles.bodyMedium.copyWith(
                height: 1.6,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
