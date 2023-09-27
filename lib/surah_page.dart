import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:prayer_app/combined_output.dart';
import 'package:prayer_app/importanFiles/surahInBangla.dart';
import 'package:prayer_app/importanFiles/surahInEnglish.dart';
import 'package:prayer_app/surah_name.dart';

// String surah='1';

class SurahPage extends StatefulWidget {
  final String surahNumber;
  final int surah_start_index;
  final int surah_end_index;
  final bool from_search;
  const SurahPage({
    super.key,
    required this.surahNumber,
    required this.surah_start_index,
    required this.surah_end_index,
    required this.from_search,
  });

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  late String surahName;
  late int surahIndex;
  late int surahLength;

  late int start;
  late int end;

  List<List<String>> verseValues = [];
  // List<String> verseValues2 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print(widget.from_search);
    start = widget.surah_start_index;
    end = widget.surah_end_index;
    // surah = surahNumber;
// mainlist = surahlist['data'];
    surahIndex = int.parse(widget.surahNumber) - 1;
    surahName = surahEnglish[surahIndex]["transliteration"] as String;
    List<Map<String, dynamic>> versesList =
        surahEnglish[surahIndex]["verses"] as List<Map<String, dynamic>>;
    List<Map<String, dynamic>> versesList2 =
        surahBangla[surahIndex]["verses"] as List<Map<String, dynamic>>;
    verseValues.add([
      "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ",
      "In the name of Allah, the Entirely Merciful, the Especially Merciful",
      "শুরু করছি আল্লাহর নামে যিনি পরম করুণাময়, অতি দয়ালু।"
    ]);
    for (var i = 0; i < versesList.length; i++) {
      if (!(surahIndex == 0 && i == 0)) {
        List<String> kk = [
          versesList[i]["text"],
          versesList[i]["translation"],
          versesList2[i]["translation"]
        ];
        verseValues.add(kk);
      }
      // verseValues.add(versesList[i]["text"]);
    }
    surahLength = verseValues.length;
    // //print(surahlist['data'][0]);
  }

  int translateAyah = 0;
  int translateAyah_en = 0;

  double _fontSize = 30.0;

  Widget build(BuildContext context) {
    // surah = widget.surahNumber;
    void showPopup(BuildContext context) {
      setState(() {
        // isPopupVisible = true;
      });

      void updateParent() {
        setState(() {});
      }

      // show
      // showDialog(
      // showDialog(context: context, builder: builder)
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
              height: 100,
              width: double.infinity, // Adjust the height as needed
              child: Column(
                children: [
                  Container(
                    height: 20,
                    width: 200,
                    child: Slider(
                      value: _fontSize,
                      min: 30.0,
                      max: 100.0,
                      onChanged: (double value) {
                        updateParent();
                        setState(() {
                          _fontSize =
                              value; // Update the variable when the slider changes
                        });
                      },
                    ),
                  ),
                  // Content for your pop-up section
                ],
              ),
            );
          });
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(surahName),
      ),
      body: Container(
          child: ListView.builder(
        itemCount: surahLength,
        itemBuilder: (context, index) {
          //print("start: ${start}, end: ${end}");
          if (index >= start && index <= end) {
            //print(surahEnglish.length);
            String val = verseValues[index][0];
            String val_en = verseValues[index][1];
            String val_bn = verseValues[index][2];
            int numNum = index;
            if (index != 0) {
              val = val + "((" + index.toString() + "))";
            }
            // String val = mainlist[index]['text'];
            // int numNum = mainlist[index]['numberInSurah'];
            // String num = numNum.toString();
            val = val.trimLeft();
            val = val.trimRight();
            String translateAyah_val = val_bn;
            if (translateAyah_en == 1) {
              translateAyah_val = val_en;
            }

            return GestureDetector(
              child: Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      // color: const Color.fromARGB(255, 227, 227, 227),
                      borderRadius: BorderRadius.circular(20)),
                  child: translateAyah == 1 && index != 0
                      ? Column(
                          children: [
                            Text(
                              "${val}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'arabic1',
                                fontSize: _fontSize,
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  translateAyah_en = 1 - translateAyah_en;
                                  setState(() {});
                                },
                                child: Text(
                                  "${translateAyah_val}",
                                  style: TextStyle(
                                    // fontFamily: 'arabic1',
                                    fontSize: _fontSize - 15,
                                  ),
                                )),
                          ],
                        )
                      : Column(
                          children: [
                            Text(
                              "${val}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'arabic1',
                                fontSize: _fontSize,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              onLongPress: () {
                showPopup(context);
              },
              onTap: () {
                ////print("Ayah is clicked");
                setState(() {
                  translateAyah = 1 - translateAyah;
                });
              },
            );
            // val = val.replaceRange(39, val.length, '')+"بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيم\n ";
          } else {
            return Container();
          }
        },
      )),
    );
  }
}

// import 'package:flutter/material.dart';

