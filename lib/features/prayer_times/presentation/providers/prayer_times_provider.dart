import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_app/core/providers/service_providers.dart';
import 'package:prayer_app/core/utils/result.dart';
import 'package:prayer_app/features/prayer_times/data/prayer_times_repository.dart';
import 'package:prayer_app/features/prayer_times/domain/prayer_time.dart';

// Repository Provider
final prayerTimesRepositoryProvider = Provider<PrayerTimesRepository>((ref) {
  final httpService = ref.watch(httpServiceProvider);
  return PrayerTimesRepository(httpService);
});

// Prayer Times Provider
final todayPrayerTimesProvider = FutureProvider<Result<PrayerTime>>((ref) async {
  final repository = ref.watch(prayerTimesRepositoryProvider);
  return repository.getTodayPrayerTimes();
});
