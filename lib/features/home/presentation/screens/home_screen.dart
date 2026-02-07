import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_app/core/constants/app_constants.dart';
import 'package:prayer_app/core/constants/asset_paths.dart';
import 'package:prayer_app/core/providers/service_providers.dart';
import 'package:prayer_app/core/theme/app_colors.dart';
import 'package:prayer_app/core/theme/text_styles.dart';
import 'package:prayer_app/features/prayer_times/presentation/screens/prayer_times_screen.dart';
import 'package:prayer_app/features/tasbih/presentation/screens/tasbih_screen.dart';
import 'package:prayer_app/features/names/presentation/screens/names_screen.dart';
import 'package:prayer_app/features/quran/presentation/screens/quran_list_screen.dart';
import 'package:prayer_app/features/hadith/presentation/screens/hadith_screen.dart';
import 'package:prayer_app/full_quran.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final box = ref.watch(storageBoxProvider);
    final bookmarkData = box.get(AppConstants.quranIndexKey) as List<dynamic>? ?? [0, "Al-Fatiha"];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A4D2E),
              Color(0xFF2E7D4E),
              Color(0xFF1A4D2E),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  _ModernHeader(),
                  const SizedBox(height: 30),

                  // Quran Bookmark Card
                  _ModernQuranCard(
                    surahNumber: bookmarkData[0] as int,
                    surahName: bookmarkData[1] as String,
                    onTap: () => _navigateToQuran(context),
                  ),
                  const SizedBox(height: 30),

                  // Features Section
                  const Text(
                    'Explore',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Feature Cards
                  _ModernFeatureCard(
                    title: 'Quran',
                    subtitle: 'Read & explore 114 surahs',
                    icon: Icons.menu_book_rounded,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00897B), Color(0xFF00695C)],
                    ),
                    onTap: () => _navigateToQuranList(context),
                  ),
                  const SizedBox(height: 12),

                  _ModernFeatureCard(
                    title: 'Prayer Times',
                    subtitle: 'Daily prayer schedule',
                    icon: Icons.access_time_rounded,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4A90E2), Color(0xFF2962FF)],
                    ),
                    onTap: () => _navigateToPrayerTimes(context),
                  ),
                  const SizedBox(height: 12),

                  _ModernFeatureCard(
                    title: 'Tasbih',
                    subtitle: 'Digital dhikr counter',
                    icon: Icons.rotate_right_rounded,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF50C878), Color(0xFF2E7D4E)],
                    ),
                    onTap: () => _navigateToTasbih(context),
                  ),
                  const SizedBox(height: 12),

                  _ModernFeatureCard(
                    title: 'Hadith',
                    subtitle: 'Sahih Bukhari collection',
                    icon: Icons.auto_stories_rounded,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE74C3C), Color(0xFFC0392B)],
                    ),
                    onTap: () => _navigateToHadith(context),
                  ),
                  const SizedBox(height: 12),

                  _ModernFeatureCard(
                    title: '99 Names of Allah',
                    subtitle: 'Beautiful names with meanings',
                    icon: Icons.star_rounded,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFF39C12), Color(0xFFE67E22)],
                    ),
                    onTap: () => _navigateToNames(context),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToQuran(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FullQuran(fromHome: true)),
    );
  }

  void _navigateToQuranList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QuranListScreen()),
    );
  }

  void _navigateToPrayerTimes(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PrayerTimesScreen()),
    );
  }

  void _navigateToTasbih(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TasbihScreen()),
    );
  }

  void _navigateToHadith(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HadithScreen()),
    );
  }

  void _navigateToNames(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NamesScreen()),
    );
  }
}

// Modern Header Widget
class _ModernHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Assalamu Alaikum',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Iman',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.mosque,
            color: Colors.white,
            size: 28,
          ),
        ),
      ],
    );
  }
}

// Modern Quran Card
class _ModernQuranCard extends StatelessWidget {
  final int surahNumber;
  final String surahName;
  final VoidCallback onTap;

  const _ModernQuranCard({
    required this.surahNumber,
    required this.surahName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFDF98FA),
              Color(0xFF9055FF),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.menu_book_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Last Read',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              surahName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Surah ${surahNumber + 1}',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Continue Reading',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Modern Feature Card
class _ModernFeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Gradient gradient;
  final VoidCallback onTap;

  const _ModernFeatureCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A4D2E),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
