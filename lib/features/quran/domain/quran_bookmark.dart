class QuranBookmark {
  final int pageIndex;
  final String surahName;

  const QuranBookmark({
    required this.pageIndex,
    required this.surahName,
  });

  factory QuranBookmark.fromList(List<dynamic> list) {
    return QuranBookmark(
      pageIndex: list[0] as int,
      surahName: list[1] as String,
    );
  }

  List<dynamic> toList() {
    return [pageIndex, surahName];
  }
}
