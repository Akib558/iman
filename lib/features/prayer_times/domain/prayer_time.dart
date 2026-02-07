class PrayerTime {
  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final DateTime date;

  const PrayerTime({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.date,
  });

  factory PrayerTime.fromJson(Map<String, dynamic> json, DateTime date) {
    final timings = json['timings'] as Map<String, dynamic>;
    
    return PrayerTime(
      fajr: _cleanTime(timings['Fajr'] as String),
      dhuhr: _cleanTime(timings['Dhuhr'] as String),
      asr: _cleanTime(timings['Asr'] as String),
      maghrib: _cleanTime(timings['Maghrib'] as String),
      isha: _cleanTime(timings['Isha'] as String),
      date: date,
    );
  }

  static String _cleanTime(String time) {
    // Remove timezone suffix like " (+06)"
    return time.replaceAll(RegExp(r' \([^)]+\)'), '').trim();
  }

  Map<String, String> toMap() {
    return {
      'Fajr': fajr,
      'Dhuhr': dhuhr,
      'Asr': asr,
      'Maghrib': maghrib,
      'Isha': isha,
    };
  }

  List<MapEntry<String, String>> get entries => toMap().entries.toList();
}
