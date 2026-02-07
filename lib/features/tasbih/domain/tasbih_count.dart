class TasbihCount {
  final String dhikrId;
  final int count;

  const TasbihCount({
    required this.dhikrId,
    required this.count,
  });

  TasbihCount copyWith({
    String? dhikrId,
    int? count,
  }) {
    return TasbihCount(
      dhikrId: dhikrId ?? this.dhikrId,
      count: count ?? this.count,
    );
  }
}
