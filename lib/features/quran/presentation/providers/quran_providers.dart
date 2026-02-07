import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_app/features/quran/data/quran_repository.dart';
import 'package:prayer_app/features/quran/domain/quran_bookmark.dart';
import 'package:prayer_app/features/quran/domain/surah.dart';

// Repository Provider
final quranRepositoryProvider = Provider<QuranRepository>((ref) {
  return QuranRepository();
});

// Surahs List Provider
final surahsProvider = Provider<List<Surah>>((ref) {
  final repository = ref.watch(quranRepositoryProvider);
  return repository.getAllSurahs();
});

// Search Query Provider
final searchQueryProvider = StateProvider<String>((ref) => '');

// Filtered Surahs Provider
final filteredSurahsProvider = Provider<List<Surah>>((ref) {
  final repository = ref.watch(quranRepositoryProvider);
  final query = ref.watch(searchQueryProvider);
  return repository.searchSurahs(query);
});

// Bookmark Provider
final quranBookmarkProvider = StateNotifierProvider<QuranBookmarkNotifier, QuranBookmark?>((ref) {
  final repository = ref.watch(quranRepositoryProvider);
  return QuranBookmarkNotifier(repository);
});

class QuranBookmarkNotifier extends StateNotifier<QuranBookmark?> {
  final QuranRepository _repository;

  QuranBookmarkNotifier(this._repository) : super(null) {
    _loadBookmark();
  }

  void _loadBookmark() {
    state = _repository.getBookmark();
  }

  Future<void> saveBookmark(int pageIndex, String surahName) async {
    final bookmark = QuranBookmark(
      pageIndex: pageIndex,
      surahName: surahName,
    );
    await _repository.saveBookmark(bookmark);
    state = bookmark;
  }
}
