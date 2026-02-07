import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_app/core/theme/app_colors.dart';
import 'package:prayer_app/core/theme/text_styles.dart';
import 'package:prayer_app/core/utils/date_time_utils.dart';
import 'package:prayer_app/core/utils/result.dart';
import 'package:prayer_app/core/widgets/error_widget.dart' as custom;
import 'package:prayer_app/core/widgets/loading_widget.dart';
import 'package:prayer_app/features/prayer_times/presentation/providers/prayer_times_provider.dart';

class PrayerTimesScreen extends ConsumerWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayerTimesAsync = ref.watch(todayPrayerTimesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Times'),
      ),
      body: prayerTimesAsync.when(
        data: (result) {
          return switch (result) {
            Success(data: final prayerTime) => _PrayerTimesList(
                prayerTime: prayerTime,
              ),
            Failure(message: final message) => custom.ErrorWidget(
                message: message,
                onRetry: () => ref.invalidate(todayPrayerTimesProvider),
              ),
          };
        },
        loading: () => const LoadingWidget(
          message: 'Loading prayer times...',
        ),
        error: (error, stack) => custom.ErrorWidget(
          message: 'An unexpected error occurred',
          onRetry: () => ref.invalidate(todayPrayerTimesProvider),
        ),
      ),
    );
  }
}

class _PrayerTimesList extends StatelessWidget {
  final prayerTime;

  const _PrayerTimesList({required this.prayerTime});

  @override
  Widget build(BuildContext context) {
    final entries = prayerTime.entries;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.backgroundDark, AppColors.backgroundLight],
        ),
      ),
      child: Column(
        children: [
          // Header Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  DateTimeUtils.formatDate(prayerTime.date, format: 'EEEE'),
                  style: TextStyles.heading3.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  DateTimeUtils.formatDate(prayerTime.date),
                  style: TextStyles.bodyLarge.copyWith(
                    color: AppColors.textPrimary.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),

          // Prayer Times List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return _PrayerTimeCard(
                  name: entry.key,
                  time: entry.value,
                  isFirst: index == 0,
                  isLast: index == entries.length - 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PrayerTimeCard extends StatelessWidget {
  final String name;
  final String time;
  final bool isFirst;
  final bool isLast;

  const _PrayerTimeCard({
    required this.name,
    required this.time,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: isLast ? 16 : 12,
        top: isFirst ? 8 : 0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryDark.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getPrayerIcon(name),
                  color: AppColors.primaryDark,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                name,
                style: TextStyles.heading3.copyWith(fontSize: 18),
              ),
            ],
          ),
          Text(
            DateTimeUtils.formatTime(time),
            style: TextStyles.heading3.copyWith(
              fontSize: 18,
              color: AppColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getPrayerIcon(String prayerName) {
    switch (prayerName.toLowerCase()) {
      case 'fajr':
        return Icons.wb_twilight;
      case 'dhuhr':
        return Icons.wb_sunny;
      case 'asr':
        return Icons.wb_sunny_outlined;
      case 'maghrib':
        return Icons.wb_twilight;
      case 'isha':
        return Icons.nights_stay;
      default:
        return Icons.access_time;
    }
  }
}
