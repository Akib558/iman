class AllahName {
  final int id;
  final String arabic;
  final String english;
  final String englishMeaning;
  final String bangla;
  final String banglaMeaning;

  const AllahName({
    required this.id,
    required this.arabic,
    required this.english,
    required this.englishMeaning,
    required this.bangla,
    required this.banglaMeaning,
  });

  factory AllahName.fromJson(Map<String, dynamic> json) {
    return AllahName(
      id: json['id'] as int,
      arabic: json['arabic'] as String,
      english: json['english'] as String,
      englishMeaning: json['englishmeaning'] as String,
      bangla: json['bangla'] as String,
      banglaMeaning: json['banglameaning'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'arabic': arabic,
      'english': english,
      'englishmeaning': englishMeaning,
      'bangla': bangla,
      'banglameaning': banglaMeaning,
    };
  }
}
