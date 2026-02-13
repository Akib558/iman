import '../domain/ayah.dart';
import '../../../importanFiles/surahInBangla.dart';
import '../../../importanFiles/surahInEnglish.dart';

class AyahRepository {
  List<Ayah> getAyahsForSurah(int surahNumber) {
    if (surahNumber < 1 || surahNumber > 114) {
      return [];
    }

    final surahIndex = surahNumber - 1;
    final banglaVerses = surahBangla[surahIndex]['verses'] as List;
    final englishVerses = surahEnglish[surahIndex]['verses'] as List;

    final List<Ayah> ayahs = [];

    for (int i = 0; i < banglaVerses.length; i++) {
      final ayah = Ayah.fromJson(
        banglaVerses[i] as Map<String, dynamic>,
        englishVerses[i] as Map<String, dynamic>,
        surahNumber,
      );
      ayahs.add(ayah);
    }

    return ayahs;
  }

  Ayah? getAyah(int surahNumber, int ayahNumber) {
    final ayahs = getAyahsForSurah(surahNumber);
    if (ayahNumber < 1 || ayahNumber > ayahs.length) {
      return null;
    }
    return ayahs[ayahNumber - 1];
  }

  Map<String, dynamic> getSurahMetadata(int surahNumber) {
    if (surahNumber < 1 || surahNumber > 114) {
      return {};
    }

    final surahIndex = surahNumber - 1;
    return {
      'name': surahBangla[surahIndex]['name'],
      'transliteration': surahBangla[surahIndex]['transliteration'],
      'translationBangla': surahBangla[surahIndex]['translation'],
      'translationEnglish': surahEnglish[surahIndex]['translation'],
      'type': surahBangla[surahIndex]['type'],
      'totalVerses': surahBangla[surahIndex]['total_verses'],
    };
  }
}
