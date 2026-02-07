class Surah {
  final String place;
  final String type;
  final int count;
  final int revelationOrder;
  final int rukus;
  final String title;
  final String titleAr;
  final String titleEn;
  final String index;
  final String pages;
  final String page;
  final int start;

  const Surah({
    required this.place,
    required this.type,
    required this.count,
    required this.revelationOrder,
    required this.rukus,
    required this.title,
    required this.titleAr,
    required this.titleEn,
    required this.index,
    required this.pages,
    required this.page,
    required this.start,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      place: json['place'] as String,
      type: json['type'] as String,
      count: json['count'] as int,
      revelationOrder: json['revelationOrder'] as int,
      rukus: json['rukus'] as int,
      title: json['title'] as String,
      titleAr: json['titleAr'] as String,
      titleEn: json['titleEn'] as String,
      index: json['index'] as String,
      pages: json['pages'] as String,
      page: json['page'] as String,
      start: json['start'] as int,
    );
  }

  int get surahNumber => int.parse(index);
  
  bool get isMeccan => type == 'Makkiyah';
}
