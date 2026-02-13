import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/ayah_repository.dart';
import '../../data/bookmark_repository.dart';
import '../../domain/ayah.dart';
import '../../domain/ayah_bookmark.dart';
import '../../../../core/constants/arabic_fonts.dart';

final ayahRepositoryProvider = Provider<AyahRepository>((ref) {
  return AyahRepository();
});

final bookmarkRepositoryProvider = Provider<BookmarkRepository>((ref) {
  final repo = BookmarkRepository();
  repo.init();
  return repo;
});

final currentSurahProvider = StateProvider<int>((ref) => 1);

final currentAyahIndexProvider = StateProvider<int>((ref) => 0);

final showBanglaTranslationProvider = StateProvider<bool>((ref) => true);

final showEnglishTranslationProvider = StateProvider<bool>((ref) => true);

final arabicFontSizeProvider = StateProvider<double>((ref) => 32.0);

final translationFontSizeProvider = StateProvider<double>((ref) => 16.0);

final arabicFontFamilyProvider = StateProvider<String>((ref) => ArabicFonts.defaultFont);

final surahAyahsProvider = Provider.family<List<Ayah>, int>((ref, surahNumber) {
  final repository = ref.watch(ayahRepositoryProvider);
  return repository.getAyahsForSurah(surahNumber);
});

final currentAyahProvider = Provider<Ayah?>((ref) {
  final surahNumber = ref.watch(currentSurahProvider);
  final ayahIndex = ref.watch(currentAyahIndexProvider);
  final ayahs = ref.watch(surahAyahsProvider(surahNumber));
  
  if (ayahIndex < 0 || ayahIndex >= ayahs.length) {
    return null;
  }
  
  return ayahs[ayahIndex];
});

final surahMetadataProvider = Provider.family<Map<String, dynamic>, int>((ref, surahNumber) {
  final repository = ref.watch(ayahRepositoryProvider);
  return repository.getSurahMetadata(surahNumber);
});

class ReadingPreferences {
  final bool showBangla;
  final bool showEnglish;
  final double arabicFontSize;
  final double translationFontSize;
  final String arabicFontFamily;

  ReadingPreferences({
    required this.showBangla,
    required this.showEnglish,
    required this.arabicFontSize,
    required this.translationFontSize,
    required this.arabicFontFamily,
  });
}

final readingPreferencesProvider = Provider<ReadingPreferences>((ref) {
  return ReadingPreferences(
    showBangla: ref.watch(showBanglaTranslationProvider),
    showEnglish: ref.watch(showEnglishTranslationProvider),
    arabicFontSize: ref.watch(arabicFontSizeProvider),
    translationFontSize: ref.watch(translationFontSizeProvider),
    arabicFontFamily: ref.watch(arabicFontFamilyProvider),
  );
});

// Bookmark providers
final bookmarksProvider = StateProvider<List<AyahBookmark>>((ref) {
  final repo = ref.watch(bookmarkRepositoryProvider);
  return repo.getAllBookmarks();
});

final isAyahBookmarkedProvider = Provider.family<bool, String>((ref, bookmarkId) {
  final bookmarks = ref.watch(bookmarksProvider);
  return bookmarks.any((b) => b.bookmarkId == bookmarkId);
});
