class AyahBookmark {
  final int surahNumber;
  final int ayahNumber;
  final String surahName;
  final String ayahTextPreview;
  final String? notes;
  final DateTime createdAt;
  final String? category;

  const AyahBookmark({
    required this.surahNumber,
    required this.ayahNumber,
    required this.surahName,
    required this.ayahTextPreview,
    this.notes,
    required this.createdAt,
    this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'surahNumber': surahNumber,
      'ayahNumber': ayahNumber,
      'surahName': surahName,
      'ayahTextPreview': ayahTextPreview,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'category': category,
    };
  }

  factory AyahBookmark.fromJson(Map<String, dynamic> json) {
    return AyahBookmark(
      surahNumber: json['surahNumber'] as int,
      ayahNumber: json['ayahNumber'] as int,
      surahName: json['surahName'] as String,
      ayahTextPreview: json['ayahTextPreview'] as String,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      category: json['category'] as String?,
    );
  }

  AyahBookmark copyWith({
    String? notes,
    String? category,
  }) {
    return AyahBookmark(
      surahNumber: surahNumber,
      ayahNumber: ayahNumber,
      surahName: surahName,
      ayahTextPreview: ayahTextPreview,
      notes: notes ?? this.notes,
      createdAt: createdAt,
      category: category ?? this.category,
    );
  }

  String get bookmarkId => '$surahNumber-$ayahNumber';
}
