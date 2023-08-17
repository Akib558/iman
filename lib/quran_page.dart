import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:prayer_app/surah_page.dart';
import 'package:prayer_app/surah_name.dart';
import 'package:prayer_app/juz.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  late Future<Map<String, dynamic>> surahlist;
  // late List<dynamic> mainlist;
  Future<Map<String, dynamic>> getQuranFull() async {
    try {
      // String cityName = 'Dhaka';
      final res =
          await http.get(Uri.parse('http://api.alquran.cloud/v1/surah'));

      final data = jsonDecode(res.body);
      if (data['code'] != 200) {
        throw "An unexpected errorrrrrrrrrrrrr";
      }


      return data;

      // print(data['list'][0]['main']['temp']);

      // temp = data['list'][0]['main']['temp'] - 273;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {

    super.initState();
    surahlist = getQuranFull();
    // print(mainlist[0]);
    // mainlist = surahlist['data'];
    // print(surahlist['data'][0]);
  }

  int surahliststatus = 1;

  @override
  Widget build(BuildContext context) {
    // print(surahlist);
    return Scaffold(
      appBar: AppBar(
        title: const Text('hello'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      height: 30,
                      child: Center(child: Text('button1')),
                      decoration: BoxDecoration(
                        color: surahliststatus == 1 ? Colors.red : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onTap: () {
                      surahliststatus = 1;
                      print("button1 clicked");
                      // initState();
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      height: 30,
                      child: Center(child: Text('button2')),
                      decoration: BoxDecoration(
                        color: surahliststatus != 1 ? Colors.red : Colors.grey,
                        borderRadius: BorderRadius.circular(10),

                      ),
                    ),
                    onTap: () {
                      surahliststatus = 0;
                      print("button2 clicked");
                      setState(() {});
                      // initState();
                    },
                  ),
                )
              ],
            ),
          ),
          surahliststatus == 1
              ? Expanded(
                  child: FutureBuilder(
                    future: surahlist,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 0, 0, 0),
                          strokeWidth: 10,
                        ));
                      }
                      final data = snapshot.data!;
                      final mainlist = data['data'];
                      // final Map<String, dynamic> mainlist = data['data'];
                      // print(mainlist);
                      return ListView.builder(
                        itemCount: mainlist.length,
                        itemBuilder: (context, index) {
                          // final val = mainlist[index];
                          final surahName =
                              surahNames[index]["title"] as String;
                          final surahNameArabic =
                              surahNames[index]["titleAr"] as String;
                          final surahVerses = surahNames[index]["count"];
                          final surahIndex =
                              int.parse(surahNames[index]["index"] as String);
                          return Container(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            // decoration: BoxDecoration(

                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      // return SurahPage(surahNumber:val['number'].toString());
                                      return SurahPage(
                                          surahNumber: surahIndex.toString());
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                // tr: MainAxisAlignment.start,                    // height: 50,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 186, 184, 184),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            // Text(val['number'].toString()+'. ',
                                            Text(
                                              surahIndex.toString() + '. ',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Text('')
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              // val['englishName'],
                                              surahName,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            // Text(val['numberOfAyahs'].toString()+' verses'),
                                            Text(surahVerses.toString() +
                                                ' verses'),
                                          ],
                                        ),
                                        Spacer(),
                                        Text(
                                          // val['name'],
                                          surahNameArabic,
                                          style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'arabic1',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        // decoration: BoxDecoration(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return JuzPage(
                                    juzNumber: (index+1).toString(),
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            // tr: MainAxisAlignment.start,                    // height: 50,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 186, 184, 184),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Juz ${index+1}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
