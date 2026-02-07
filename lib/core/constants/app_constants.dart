class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Iman';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String storageBoxName = 'DB1';
  static const String quranIndexKey = 'quran_index';
  static const String dhikirListKey = 'dhikirList';

  // API
  static const String aladhanBaseUrl = 'https://api.aladhan.com/v1';
  static const String quranApiBaseUrl = 'http://api.alquran.cloud/v1';

  // Default Values
  static const String defaultCity = 'Dhaka';
  static const String defaultCountry = 'Bangladesh';
  static const int defaultPrayerMethod = 1;

  // UI
  static const double defaultElevation = 4.0;
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 10.0;
}
