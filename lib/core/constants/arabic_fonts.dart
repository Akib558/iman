class ArabicFonts {
  static const String amiri = 'Amiri';
  static const String scheherazade = 'Scheherazade';
  static const String notoNaskhArabic = 'NotoNaskhArabic';
  
  static const List<String> availableFonts = [
    amiri,
    scheherazade,
    notoNaskhArabic,
  ];
  
  static const Map<String, String> fontDisplayNames = {
    amiri: 'Amiri',
    scheherazade: 'Scheherazade New',
    notoNaskhArabic: 'Noto Naskh Arabic',
  };
  
  static const Map<String, String> fontDescriptions = {
    amiri: 'Classic calligraphic style',
    scheherazade: 'Modern readable style',
    notoNaskhArabic: 'Universal clean style',
  };
  
  static const String defaultFont = notoNaskhArabic;
  
  static String getSampleText() {
    return 'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ';
  }
}
