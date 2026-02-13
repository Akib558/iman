import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:prayer_app/core/theme/app_colors.dart';
import 'package:prayer_app/core/theme/text_styles.dart';
import 'package:prayer_app/features/quran/domain/surah.dart';
import 'package:prayer_app/features/quran/presentation/providers/quran_providers.dart';
import 'package:prayer_app/features/quran/presentation/screens/ayah_reading_screen.dart';
import 'package:prayer_app/features/quran/presentation/widgets/enhanced_continue_reading_card.dart';
import 'package:prayer_app/full_quran.dart';

class QuranListScreen extends ConsumerWidget {
  const QuranListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(searchQueryProvider); // Track for rebuilds
    final surahs = ref.watch(filteredSurahsProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_book),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FullQuran(fromHome: false),
                ),
              );
            },
            tooltip: 'Page View',
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
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  ref.read(searchQueryProvider.notifier).state = value;
                },
                decoration: InputDecoration(
                  hintText: 'Search surah...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),

            // Surah List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: surahs.length + (searchQuery.isEmpty ? 1 : 0),
                itemBuilder: (context, index) {
                  // Show continue reading card at the top when not searching
                  if (searchQuery.isEmpty && index == 0) {
                    return EnhancedContinueReadingCard(
                      onTap: () => _continueReading(context),
                    );
                  }
                  
                  final surahIndex = searchQuery.isEmpty ? index - 1 : index;
                  final surah = surahs[surahIndex];
                  return _SurahCard(
                    surah: surah,
                    onTap: () => _navigateToReader(context, surah),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToReader(BuildContext context, Surah surah) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AyahReadingScreen(
          surahNumber: surah.surahNumber,
          initialAyahIndex: 0,
        ),
      ),
    );
  }

  void _continueReading(BuildContext context) {
    final myBox = Hive.box("DB1");
    final readingPosition = myBox.get("quran_reading_position");
    
    if (readingPosition != null && readingPosition is Map) {
      final surahNumber = readingPosition['surahNumber'] as int? ?? 1;
      final ayahIndex = readingPosition['ayahIndex'] as int? ?? 0;
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AyahReadingScreen(
            surahNumber: surahNumber,
            initialAyahIndex: ayahIndex,
          ),
        ),
      );
    } else {
      // Start from the beginning if no reading position
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AyahReadingScreen(
            surahNumber: 1,
            initialAyahIndex: 0,
          ),
        ),
      );
    }
  }
}

class _SurahCard extends StatelessWidget {
  final Surah surah;
  final VoidCallback onTap;

  const _SurahCard({
    required this.surah,
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
              // Surah Number Badge
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    surah.surahNumber.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Surah Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      surah.title,
                      style: TextStyles.heading3.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${surah.titleEn} • ${surah.count} verses',
                      style: TextStyles.bodySmall.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              // Arabic Name & Type Badge
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    surah.titleAr,
                    style: TextStyles.arabic.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: surah.isMeccan
                          ? Colors.orange.withOpacity(0.2)
                          : Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      surah.isMeccan ? 'Meccan' : 'Medinan',
                      style: TextStyles.bodySmall.copyWith(
                        fontSize: 10,
                        color: surah.isMeccan ? Colors.orange[800] : Colors.green[800],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 8),
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
