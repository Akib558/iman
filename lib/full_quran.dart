import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:prayer_app/importanFiles/page.dart';
import 'package:prayer_app/importanFiles/surahInBangla.dart';
import 'package:prayer_app/importanFiles/global_variable.dart';
import 'package:prayer_app/importanFiles/surahInEnglish.dart';

class FullQuran extends StatefulWidget {
  final bool fromHome;
  const FullQuran({super.key, required this.fromHome});

  @override
  State<FullQuran> createState() => _FullQuranState();
}

class _FullQuranState extends State<FullQuran> {
  // List<int> lang_code = List.generate(700, (index) => index + 1);
  List<int> lang_code = List<int>.filled(700, 0);
  final myBox = Hive.box("DB1");
  int newIndex = 0;
  @override
  void initState() {
    super.initState();
    if (widget.fromHome) {
      var kk = myBox.get("quran_index");
      newIndex = kk[0];
      newIndex = max(1, newIndex);
    }
    ////print("inside full quran page initstate");
  }

  double _fontSize = 30.0;
  @override
  Widget build(BuildContext context) {
    // Navigator.pop(context, "hello");
    ////print("inside full quran page");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quran"),
      ),
      body: GestureDetector(
        onScaleUpdate: (details) {
          double newFontSize = _fontSize * details.scale * 1.2;
          setState(() {
            _fontSize = newFontSize.clamp(
                20.0, 60.0); // Limit font size between 10 and 50
          });
        },
        child: Container(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
          margin: const EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
          child: ListView.builder(
            itemCount: pageinfo.length - newIndex,
            itemBuilder: (context, index) {
              index += newIndex;
              Map<String, String> start =
                  pageinfo[index]["start"] as Map<String, String>;
              Map<String, String> end =
                  pageinfo[index]["end"] as Map<String, String>;

              String startSurahName = start["name"] as String;
              String endSurahName = end["name"] as String;

              int startSurah = int.parse(start["index"] as String);
              int startSurahIndex = int.parse(start["verse"] as String);

              int endSurah = int.parse(end["index"] as String);
              int endSurahIndex = int.parse(end["verse"] as String);
              List<String> pp = [];
              List<String> ppBangla = [];
              List<String> ppEnglish = [];
              List<int> ppId = [];
              myBox.put("quran_index", [index - 1, startSurahName]);
              // ////print("start surah ${start_surah}");
              // ////print("start surah index ${start_surah_index}");
              // //print("end surah ${end_surah}");
              // //print("start surah index ${end_surah_index}");
              startSurah--;
              endSurah--;
              startSurahIndex--;
              endSurahIndex--;

              if (startSurah == endSurah) {
                List<Map<String, dynamic>> tmp = surahBangla[startSurah]
                    ["verses"] as List<Map<String, dynamic>>;
                List<Map<String, dynamic>> tmp2 = surahEnglish[startSurah]
                    ["verses"] as List<Map<String, dynamic>>;
                demo.add(tmp);
                for (var j = startSurahIndex; j <= endSurahIndex; j++) {
                  if (tmp[j]['id'] == 1 && index != 0) {
                    pp.add("بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ");
                    ppEnglish.add(
                        "In the name of Allah, the Entirely Merciful, the Especially Merciful");
                    ppBangla.add(
                        "শুরু করছি আল্লাহর নামে যিনি পরম করুণাময়, অতি দয়ালু।");
                    ppId.add(0);
                  }
                  pp.add(tmp[j]['text']);
                  ppBangla.add(tmp[j]["translation"]);
                  ppEnglish.add(tmp2[j]["translation"]);
                  ppId.add(tmp[j]['id']);
                }
              } else {
                for (var i = startSurah; i <= endSurah; i++) {
                  // pp.add("بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ");
                  if (i == startSurah) {
                    int totalVerse = surahBangla[i]["total_verses"] as int;
                    // //print(total_verse);
                    for (var j = startSurahIndex; j < totalVerse; j++) {
                      List<Map<String, dynamic>> tmp = surahBangla[startSurah]
                          ["verses"] as List<Map<String, dynamic>>;
                      List<Map<String, dynamic>> tmp2 = surahEnglish[startSurah]
                          ["verses"] as List<Map<String, dynamic>>;
                      String verseVal = tmp[j]["text"];
                      if (tmp[j]['id'] == 1) {
                        pp.add("بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ");
                        ppEnglish.add(
                            "In the name of Allah, the Entirely Merciful, the Especially Merciful");
                        ppBangla.add(
                            "শুরু করছি আল্লাহর নামে যিনি পরম করুণাময়, অতি দয়ালু।");
                        ppId.add(0);
                      }
                      pp.add(verseVal);
                      ppBangla.add(tmp[j]["translation"]);
                      ppEnglish.add(tmp2[j]["translation"]);
                      ppId.add(tmp[j]['id']);
                    }
                  } else if (i == endSurah) {
                    // int total_verse = surahBangla[end_surah]["total_verses"] as int;
                    for (var j = 0; j < endSurahIndex; j++) {
                      List<Map<String, dynamic>> tmp = surahBangla[i]["verses"]
                          as List<Map<String, dynamic>>;
                      List<Map<String, dynamic>> tmp2 = surahEnglish[i]
                          ["verses"] as List<Map<String, dynamic>>;
                      String verseVal = tmp[j]["text"];
                      if (tmp[j]['id'] == 1) {
                        pp.add("بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ");
                        ppEnglish.add(
                            "In the name of Allah, the Entirely Merciful, the Especially Merciful");
                        ppBangla.add(
                            "শুরু করছি আল্লাহর নামে যিনি পরম করুণাময়, অতি দয়ালু।");
                        ppId.add(0);
                      }
                      pp.add(verseVal);
                      ppBangla.add(tmp[j]["translation"]);
                      ppEnglish.add(tmp2[j]["translation"]);
                      ppId.add(tmp[j]['id']);
                    }
                  } else {
                    int totalVerse = surahBangla[i]["total_verses"] as int;
                    for (var j = 0; j < totalVerse; j++) {
                      List<Map<String, dynamic>> tmp = surahBangla[i]["verses"]
                          as List<Map<String, dynamic>>;
                      List<Map<String, dynamic>> tmp2 = surahEnglish[i]
                          ["verses"] as List<Map<String, dynamic>>;
                      String verseVal = tmp[j]["text"];
                      if (tmp[j]['id'] == 1) {
                        pp.add("بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ");
                        ppEnglish.add(
                            "In the name of Allah, the Entirely Merciful, the Especially Merciful");
                        ppBangla.add(
                            "শুরু করছি আল্লাহর নামে যিনি পরম করুণাময়, অতি দয়ালু।");
                        ppId.add(0);
                      }
                      pp.add(verseVal);
                      ppBangla.add(tmp[j]["translation"]);
                      ppBangla.add(tmp2[j]["translation"]);
                      ppId.add(tmp[j]['id']);
                    }
                  }
                }
              }
              // }

              bool isPopupVisible = false;

              GestureDetector selectLang(int val, String optionName) {
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        lang_code[index] = val;
                      });
                      Navigator.of(context).pop(); // Close the pop-up section
                    },
                    child: Card(
                      elevation: 3,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 247, 239, 216),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(optionName),
                      ),
                    ));
              }

              void updateParent() {
                setState(() {});
              }

              void showPopup(BuildContext context) {
                setState(() {
                  isPopupVisible = true;
                });

                // show
                // showDialog(
                // showDialog(context: context, builder: builder)
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder: (BuildContext context,
                        StateSetter setState /*You can rename this!*/) {
                      return SizedBox(
                        height: 100,
                        width: double.infinity, // Adjust the height as needed
                        child: Column(
                          children: [
                            SizedBox(
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
                            const Text(
                              'Select Language',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Container(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    selectLang(0, "Arabic"),
                                    selectLang(1, "Bangla"),
                                    selectLang(2, "English"),
                                  ]),
                            ),
                          ],
                        ),
                      );
                    });
                  },
                );
              }

              String getString(int lang) {
                String put = "";
                List<String> dd = [];
                if (lang == 0) {
                  dd = pp;
                } else if (lang == 1) {
                  dd = ppBangla;
                } else {
                  dd = ppEnglish;
                }
                // int cnt = 0;
                for (var i = 0; i < dd.length; i++) {
                  var ele = dd[i];
                  put += ele;
                  // cnt++;
                  if (ele == "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ" ||
                      ele ==
                          "শুরু করছি আল্লাহর নামে যিনি পরম করুণাময়, অতি দয়ালু।" ||
                      ele ==
                          "In the name of Allah, the Entirely Merciful, the Especially Merciful") {
                    put = '$put\n';
                    // cnt--;
                  } else
                  // if (ele != "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ")
                  if (index == 0) {
                    put += " ((${ppId[i] - 1}))  ";
                  } else {
                    put += " ((${ppId[i]}))  ";
                  }
                }
                return put;
              }

              String langSettings(int index) {
                String val = '';
                if (index == 0) {
                  val = 'arabic1';
                } else if (index == 1) {
                  val = 'bangla1';
                } else {
                  val = '';
                }
                return val;
              }

              return GestureDetector(
                onTap: () {
                  setState(() {
                    showPopup(context);
                    // lang_code[index] = 1 - lang_code[index];
                  });
                },
                child: Card(
                  // color: const Color.fromARGB(255, 255, 255, 255),
                  elevation: 5,
                  child: Container(
                      // height: 800,
                      // width: 500,
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 241, 238, 228),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  "Page: $index",
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Text(startSurahName != endSurahName
                                    ? "( $startSurahName --- $endSurahName)"
                                    : startSurahName),
                                const Spacer(),
                                Text("$startSurahIndex -- $endSurahIndex"),
                              ],
                            ),
                          ),
                          Center(
                              child: Text(
                            getString(lang_code[index]),
                            textAlign: TextAlign.center,
                            // textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontFamily: langSettings(lang_code[index]),
                                fontSize:
                                    lang_code[index] == 0 ? _fontSize : 20),
                          )),
                        ],
                      )),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

String translateText(String text1, String text2, String languageCode) {
  // Use the intl package or your preferred localization method here to translate the text.
  // You can use switch statements, if-else conditions, or a localization library
  // to provide translations for different languages.
  // Return the translated text based on the language code.
  if (languageCode == 0) {
    return text1;
  }
  return text2;
}
