import 'package:prayer_app/core/constants/app_constants.dart';
import 'package:prayer_app/core/services/local_storage_service.dart';
import 'package:prayer_app/features/quran/domain/quran_bookmark.dart';
import 'package:prayer_app/features/quran/domain/surah.dart';
import 'package:prayer_app/importanFiles/surahList.dart';

class QuranRepository {
  List<Surah> getAllSurahs() {
    return getSurahFull
        .map((json) => Surah.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Surah? getSurahByIndex(String index) {
    try {
      final json = getSurahFull.firstWhere(
        (item) => (item as Map<String, dynamic>)['index'] == index,
      );
      return Surah.fromJson(json as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  Surah? getSurahByNumber(int number) {
    final index = number.toString().padLeft(3, '0');
    return getSurahByIndex(index);
  }

  QuranBookmark? getBookmark() {
    final data = LocalStorageService.get<List>(AppConstants.quranIndexKey);
    if (data == null) return null;
    return QuranBookmark.fromList(data);
  }

  Future<void> saveBookmark(QuranBookmark bookmark) async {
    await LocalStorageService.put(
      AppConstants.quranIndexKey,
      bookmark.toList(),
    );
  }

  List<Surah> searchSurahs(String query) {
    if (query.isEmpty) return getAllSurahs();
    
    final lowerQuery = query.toLowerCase();
    return getAllSurahs().where((surah) {
      return surah.title.toLowerCase().contains(lowerQuery) ||
          surah.titleEn.toLowerCase().contains(lowerQuery) ||
          surah.titleAr.contains(query);
    }).toList();
  }
}
