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
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  int surahliststatus = 1;
  double _fontSize = 30.0;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredList = surahNames
        .where((item) => (item['title'] as String)
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();
    void updateParent() {
      setState(() {});
    }

    // ////print(surahlist);
    return Scaffold(
      appBar: AppBar(
        title: Text(surahliststatus == 0 ? "Juz" : "Quran"),
      ),
      body: GestureDetector(
        onScaleUpdate: (details) {
          double newFontSize = _fontSize * details.scale;
          setState(() {
            _fontSize = newFontSize.clamp(
                20.0, 60.0); // Limit font size between 10 and 50
          });
        },
        child: Column(
          children: [
            if (surahliststatus == 1)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      hintText: 'Search...',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2))),
                ),
              ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Card(
                          elevation: surahliststatus == 1 ? 3 : 0,
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: surahliststatus == 1
                                  ? const Color(0xFFf1eee4)
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(child: Text('Quran')),
                          ),
                        ),
                        onTap: () {
                          surahliststatus = 1;
                          ////print("button1 clicked");
                          // initState();
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Card(
                          elevation: surahliststatus == 0 ? 3 : 0,
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: surahliststatus != 1
                                  ? const Color(0xFFf1eee4)
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(child: Text('Juz')),
                          ),
                        ),
                        onTap: () {
                          surahliststatus = 0;
                          ////print("button2 clicked");
                          setState(() {});
                          // initState();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            surahliststatus == 1
                ? Expanded(
                    child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final surahNames = filteredList;
                      // final val = mainlist[index];
                      final surahName = surahNames[index]["title"] as String;
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
                                    surahNumber: surahIndex.toString(),
                                    from_search: false,
                                    surah_start_index: 0,
                                    surah_end_index: 1000,
                                  );
                                },
                              ),
                            );
                          },
                          child: Card(
                            elevation: 5,
                            child: Container(
                              // tr: MainAxisAlignment.start,                    // height: 50,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: const Color(0xFFf1eee4),
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
                                            '$surahIndex. ',
                                            style: const TextStyle(
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
                                          Text('$surahVerses verses'),
                                        ],
                                      ),
                                      const Spacer(),
                                      Text(
                                        // val['name'],
                                        surahNameArabic,
                                        style: TextStyle(
                                          fontSize: _fontSize,
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
                        ),
                      );
                    },
                  ))
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
                                      juzNumber: (index + 1).toString(),
                                    );
                                  },
                                ),
                              );
                            },
                            child: Card(
                              elevation: 5,
                              child: Container(
                                // tr: MainAxisAlignment.start,                    // height: 50,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFf1eee4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Juz ${index + 1}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
