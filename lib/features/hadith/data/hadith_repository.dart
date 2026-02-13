import 'package:prayer_app/features/hadith/domain/hadith.dart';
import 'package:prayer_app/importanFiles/ara-bukhari.dart';
import 'package:prayer_app/importanFiles/ben-bukhari.dart';
import 'package:prayer_app/importanFiles/eng-bukhari.dart';

class HadithRepository {
  List<HadithSection> getSections() {
    final metadata = ara_bukhari[0]["metadata"] as Map<String, dynamic>;
    final sections = metadata["sections"] as Map<String, dynamic>;
    final sectionDetails = metadata["section_details"] as Map<String, dynamic>;

    final List<HadithSection> sectionsList = [];

    sections.forEach((key, value) {
      if (key != "0") {
        // Skip the first metadata entry
        final details = sectionDetails[key] as Map<String, dynamic>;
        sectionsList.add(
          HadithSection(
            id: key,
            title: value as String,
            firstHadithNumber: details["hadithnumber_first"] as int,
            lastHadithNumber: details["hadithnumber_last"] as int,
          ),
        );
      }
    });

    return sectionsList;
  }

  List<Hadith> getHadithsForSection(
    int firstNumber,
    int lastNumber,
    HadithLanguage language,
  ) {
    final List<dynamic> hadiths;

    switch (language) {
      case HadithLanguage.arabic:
        hadiths = ara_bukhari[0]["hadiths"] as List<dynamic>;
        break;
      case HadithLanguage.bangla:
        hadiths = ben_bukhari[0]["hadiths"] as List<dynamic>;
        break;
      case HadithLanguage.english:
        hadiths = eng_bukhari[0]["hadiths"] as List<dynamic>;
        break;
    }

    final List<Hadith> result = [];

    for (int i = firstNumber; i <= lastNumber; i++) {
      final hadithData = hadiths[i - 1] as Map<String, dynamic>;
      result.add(
        Hadith(
          hadithnumber: hadithData["hadithnumber"] as String,
          text: hadithData["text"] as String,
        ),
      );
    }

    return result;
  }

  String getLanguageName(HadithLanguage language) {
    switch (language) {
      case HadithLanguage.arabic:
        return 'Arabic';
      case HadithLanguage.bangla:
        return 'Bangla';
      case HadithLanguage.english:
        return 'English';
    }
  }
}
