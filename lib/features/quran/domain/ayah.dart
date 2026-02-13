class Ayah {
  final int id;
  final String textArabic;
  final String translationBangla;
  final String translationEnglish;
  final int surahNumber;
  final int ayahNumber;

  const Ayah({
    required this.id,
    required this.textArabic,
    required this.translationBangla,
    required this.translationEnglish,
    required this.surahNumber,
    required this.ayahNumber,
  });

  factory Ayah.fromJson(
    Map<String, dynamic> banglaVerse,
    Map<String, dynamic> englishVerse,
    int surahNumber,
  ) {
    return Ayah(
      id: banglaVerse['id'] as int,
      textArabic: banglaVerse['text'] as String,
      translationBangla: banglaVerse['translation'] as String,
      translationEnglish: englishVerse['translation'] as String,
      surahNumber: surahNumber,
      ayahNumber: banglaVerse['id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'textArabic': textArabic,
      'translationBangla': translationBangla,
      'translationEnglish': translationEnglish,
      'surahNumber': surahNumber,
      'ayahNumber': ayahNumber,
    };
  }
}
