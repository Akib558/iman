import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
// import 'package:prayer_app/full_quran.dart';
// import 'package:prayer_app/hadith_page.dart';
// import 'package:prayer_app/compass_page.dart';
import 'package:prayer_app/home_page.dart';
import 'package:prayer_app/importanFiles/dhikirList.dart';
import 'package:prayer_app/search_surah.dart';
import 'package:prayer_app/tasbih_page.dart';
// import 'package:prayer_app/names.dart';
// import 'package:prayer_app/quran_page.dart';
// import 'package:prayer_app/surah_page.dart';
import 'package:prayer_app/prayer_time.dart';

void main() async {
  // pint("m")
  await Hive.initFlutter();
  var myBox = await Hive.openBox("DB1");
  // var myBox = await Hive.openBox("DB1");
  // final val = myBox.get("dhikirList");
  // print(dhikirList);
  // if (myBox.get("dhikirList") == null) {
  //   myBox.put("dhikirList", dhikirList);
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Iman",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFf6f1eb)),
        // primarySwatch: ,
        // primarySwatch:,
      ),
      home: HomePage(),
      // home: QuranPage(),
      // home: FullQuran(),
      // home: SurahPage(surahNumber: "114",),
      // home: PrayerTime(),
      // home: NameOfAllah(),
      // home: CompassPage(),
      // home: HadithPage(),
      // home: TasbihPage(),
      // home: SearchSurah(),
    );
  }
}
