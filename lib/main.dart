import 'package:flutter/material.dart';
import 'package:prayer_app/home_page.dart';
import 'package:prayer_app/quran_page.dart';
import 'package:prayer_app/surah_page.dart';
import 'package:prayer_app/prayer_time.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFf6f1eb)),
      ),
      // home: HomePage(),
      // home: QuranPage(),
      // home: SurahPage(surahNumber: "114",),
      home: PrayerTime(),
    );
  }
}