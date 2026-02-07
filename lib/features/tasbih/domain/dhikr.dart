class Dhikr {
  final String id;
  final String text;
  final String arabic;
  final String translationEn;
  final String translationBn;

  const Dhikr({
    required this.id,
    required this.text,
    required this.arabic,
    required this.translationEn,
    this.translationBn = '',
  });

  factory Dhikr.fromJson(Map<String, dynamic> json) {
    return Dhikr(
      id: json['id'] as String,
      text: json['dhikir'] as String,
      arabic: json['arabic'] as String,
      translationEn: json['translationEn'] as String,
      translationBn: (json['translationBn'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dhikir': text,
      'arabic': arabic,
      'translationEn': translationEn,
      'translationBn': translationBn,
    };
  }

  Dhikr copyWith({
    String? id,
    String? text,
    String? arabic,
    String? translationEn,
    String? translationBn,
  }) {
    return Dhikr(
      id: id ?? this.id,
      text: text ?? this.text,
      arabic: arabic ?? this.arabic,
      translationEn: translationEn ?? this.translationEn,
      translationBn: translationBn ?? this.translationBn,
    );
  }
}
