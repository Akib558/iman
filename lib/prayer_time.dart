import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
// import 'package:prayer_app/combined_output.dart';

// String surah='1';

class PrayerTime extends StatefulWidget {
  // final String juzNumber;
  const PrayerTime({
    super.key,
  });

  @override
  State<PrayerTime> createState() => _PrayerTimeState();
}

class _PrayerTimeState extends State<PrayerTime> {
  late Future<Map<String, dynamic>> prayerTimeList;

  Future<Map<String, dynamic>> getPrayerTimes() async {
    try {
      String demo =
          "https://api.aladhan.com/v1/calendarByCity/2023/8?city=Dhaka&country=Bangladesh&method=1";
      final res = await http
          // .get(Uri.parse('http://api.alquran.cloud/v1/surah/{juzNumber}/ar.asad'));
          .get(Uri.parse(demo));

      final data = jsonDecode(res.body);
      if (data['code'] != 200) {
        throw "An unexpected errorrrrrrrrrrrrr";
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // surah = juzNumber;
    prayerTimeList = getPrayerTimes();
    ////print(prayerTimeList);
    // //print(mainlist[0]);
    // mainlist = surahlist['data'];
    // //print(surahlist['data'][0]);
  }

  // static const redColor = Color(0xFFF4EBD9);
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    int currentDayOfMonth = currentDate.day;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Time'),
      ),
      body: Container(
        child: FutureBuilder(
          future: prayerTimeList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Color.fromARGB(255, 0, 0, 0),
                strokeWidth: 10,
              ));
            }

            final data = snapshot.data!;
            // //print(data['data'][currentDayOfMonth - 1]['timings']);
            Map<String, dynamic> prayerTimes =
                data['data'][currentDayOfMonth - 1]['timings'];
            // //print(prayerTimes);
            // final mainlist = data['data'][currentDayOfMonth - 1]['timings'];
            // Map<String, dynamic> verses = mainlist;

            // //print(mainlist);

            List<String> prayerTimesValues = [];
            prayerTimes.forEach((key, value) {
              prayerTimesValues.add(value);
            });
            List<String> prayerTimesKeyes = [];
            prayerTimes.forEach((key, value) {
              prayerTimesKeyes.add(key);
            });
            List<List<String>> prayerAndtime = [];
            for (var i = 0; i < prayerTimesValues.length; i++) {
              prayerAndtime.add([
                prayerTimesKeyes[i],
                prayerTimesValues[i].replaceAll(RegExp(r' \(\+06\)'), '')
              ]);
            }
            // //print(prayerTimesValues);
            // //print(prayerTimesKeyes);
            //print(prayerAndtime);
            // int listLength = verseKeyes.length;
            return Container(
              child: ListView.builder(
                itemCount: prayerAndtime.length,
                itemBuilder: (context, index) {
                  String prayer = prayerAndtime[index][0];
                  String time = prayerAndtime[index][1];
                  DateTime time2 = DateFormat.Hm().parse(time);
                  time = DateFormat.jm().format(time2);
                  return Card(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                prayer,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                time,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart'
