import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_app/features/hadith/data/hadith_repository.dart';
import 'package:prayer_app/features/hadith/domain/hadith.dart';

// Repository Provider
final hadithRepositoryProvider = Provider<HadithRepository>((ref) {
  return HadithRepository();
});

// Sections Provider
final hadithSectionsProvider = Provider<List<HadithSection>>((ref) {
  final repository = ref.watch(hadithRepositoryProvider);
  return repository.getSections();
});

// Selected Language Provider
final selectedLanguageProvider = StateProvider<HadithLanguage>((ref) {
  return HadithLanguage.english;
});

// Hadiths for Section Provider (family for different sections)
final hadithsForSectionProvider = Provider.family<List<Hadith>, HadithSection>(
  (ref, section) {
    final repository = ref.watch(hadithRepositoryProvider);
    final language = ref.watch(selectedLanguageProvider);
    return repository.getHadithsForSection(
      section.firstHadithNumber,
      section.lastHadithNumber,
      language,
    );
  },
);
