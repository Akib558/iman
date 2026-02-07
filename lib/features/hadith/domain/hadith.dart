class HadithSection {
  final String id;
  final String title;
  final int firstHadithNumber;
  final int lastHadithNumber;

  const HadithSection({
    required this.id,
    required this.title,
    required this.firstHadithNumber,
    required this.lastHadithNumber,
  });

  int get totalHadiths => lastHadithNumber - firstHadithNumber + 1;
}

class Hadith {
  final String hadithnumber;
  final String text;

  const Hadith({
    required this.hadithnumber,
    required this.text,
  });
}
