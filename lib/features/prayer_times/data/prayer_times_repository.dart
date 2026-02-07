import 'package:prayer_app/core/constants/app_constants.dart';
import 'package:prayer_app/core/services/http_service.dart';
import 'package:prayer_app/core/utils/date_time_utils.dart';
import 'package:prayer_app/core/utils/result.dart';
import 'package:prayer_app/features/prayer_times/domain/prayer_time.dart';

class PrayerTimesRepository {
  final HttpService _httpService;

  PrayerTimesRepository(this._httpService);

  Future<Result<PrayerTime>> getTodayPrayerTimes({
    String? city,
    String? country,
  }) async {
    try {
      final cityName = city ?? AppConstants.defaultCity;
      final countryName = country ?? AppConstants.defaultCountry;
      final year = DateTimeUtils.getCurrentYear();
      final month = DateTimeUtils.getCurrentMonth();

      final url = '${AppConstants.aladhanBaseUrl}/calendarByCity'
          '/$year/$month?city=$cityName&country=$countryName'
          '&method=${AppConstants.defaultPrayerMethod}';

      final data = await _httpService.get(url);

      if (data['code'] != 200) {
        return const Failure('Failed to fetch prayer times');
      }

      final dayData = data['data'] as List;
      final currentDay = DateTimeUtils.getCurrentDayOfMonth();
      final todayData = dayData[currentDay - 1];

      final prayerTime = PrayerTime.fromJson(
        todayData,
        DateTime.now(),
      );

      return Success(prayerTime);
    } catch (e) {
      return Failure('Error fetching prayer times: ${e.toString()}');
    }
  }
}
