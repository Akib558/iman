import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:prayer_app/combined_output.dart';
import 'package:prayer_app/importanFiles/jus-index.dart';
import 'package:prayer_app/importanFiles/surahInBangla.dart';

// String surah='1';

class JuzPage extends StatefulWidget {
  final String juzNumber;
  const JuzPage({
    super.key,
    required this.juzNumber,
  });

  @override
  State<JuzPage> createState() => _JuzPageState();
}

class _JuzPageState extends State<JuzPage> {
  Map<String, String> start = {};
  Map<String, String> end = {};
  int index = 0;
  String start_surah_name = "";
  String end_surah_name = "";
  List<String> pp = [];
  List<String> pp_bangla = [];
  List<int> pp_id = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // surah = juzNumber;
    // surahlist = getSurahFull();
    // print(mainlist[0]);
    // mainlist = surahlist['data'];
    // print(surahlist['data'][0]);
    index = int.parse(widget.juzNumber) - 1;
    start = juzIndex[index]["start"] as Map<String, String>;
    end = juzIndex[index]["end"] as Map<String, String>;
    String start_surah_name = start["name"] as String;
    String end_surah_name = end["name"] as String;

    int start_surah = int.parse(start["index"] as String);
    int start_surah_index = int.parse(start["verse"] as String);

    int end_surah = int.parse(end["index"] as String);
    int end_surah_index = int.parse(end["verse"] as String);

    // myBox.put("quran_index", [index - 1, start_surah_name]);
    // print("start surah ${start_surah}");
    // print("start surah index ${start_surah_index}");
    // print("end surah ${end_surah}");
    // print("start surah index ${end_surah_index}");
    start_surah--;
    end_surah--;
    start_surah_index--;
    end_surah_index--;

    if (start_surah == end_surah) {
      List<Map<String, dynamic>> tmp =
          surahBangla[start_surah]["verses"] as List<Map<String, dynamic>>;
      // demo.add(tmp);
      for (var j = start_surah_index; j <= end_surah_index; j++) {
        if (tmp[j]['id'] == 1 && index != 0) {
          pp.add("بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ");
          pp_id.add(0);
        }
        pp.add(tmp[j]['text']);
        pp_bangla.add(tmp[j]["translation"]);
        pp_id.add(tmp[j]['id']);
      }
    } else {
      for (var i = start_surah; i <= end_surah; i++) {
        // pp.add("بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ");
        if (i == start_surah) {
          int total_verse = surahBangla[i]["total_verses"] as int;
          // print(total_verse);
          for (var j = start_surah_index; j < total_verse; j++) {
            List<Map<String, dynamic>> tmp = surahBangla[start_surah]["verses"]
                as List<Map<String, dynamic>>;
            String verse_val = tmp[j]["text"];
            if (tmp[j]['id'] == 1 && i != 0) {
              pp.add("بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ");
              pp_id.add(0);
            }
            pp.add(verse_val);
            pp_bangla.add(tmp[j]["translation"]);
            pp_id.add(tmp[j]['id'] - (i == 0 ? 1 : 0));
          }
        } else if (i == end_surah) {
          // int total_verse = surahBangla[end_surah]["total_verses"] as int;
          for (var j = 0; j < end_surah_index; j++) {
            List<Map<String, dynamic>> tmp =
                surahBangla[i]["verses"] as List<Map<String, dynamic>>;
            String verse_val = tmp[j]["text"];
            if (tmp[j]['id'] == 1) {
              pp.add("بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ");
              pp_id.add(0);
            }
            pp.add(verse_val);
            pp_bangla.add(tmp[j]["translation"]);
            pp_id.add(tmp[j]['id']);
          }
        } else {
          int total_verse = surahBangla[i]["total_verses"] as int;
          for (var j = 0; j < total_verse; j++) {
            List<Map<String, dynamic>> tmp =
                surahBangla[i]["verses"] as List<Map<String, dynamic>>;
            String verse_val = tmp[j]["text"];
            if (tmp[j]['id'] == 1) {
              pp.add("بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ");
              pp_id.add(0);
            }
            pp.add(verse_val);
            pp_bangla.add(tmp[j]["translation"]);
            pp_id.add(tmp[j]['id']);
          }
        }
      }
    }
  }

  Widget build(BuildContext context) {
    // surah = widget.juzNumber;
    return Scaffold(
      appBar: AppBar(
        title: Text("Juz ${widget.juzNumber}"),
      ),
      body: Container(
          child: ListView.builder(
        itemCount: pp.length,
        itemBuilder: (context, index) {
          // String val = verseValues[index];
          // int numNum = index;

          // String val = mainlist[index]['text'];
          // int numNum = mainlist[index]['numberInSurah'];

          String val = pp[index];
          int numNum = pp_id[index];
          if (pp_id[index] != 0) val = val + "(( ${numNum} ))";
          // String num = numNum.toString();
          val = val.trimLeft();
          val = val.trimRight();

          // if (index == 0 &&
          //     val.length !=
          //         'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ '.length) {
          //   // String tmp = 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ';
          //   val = val.replaceFirst(
          //       'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ ', '');
          //   return Container(
          //       child: Row(
          //         children: [
          //           Text(num,
          //           softWrap: true,)
          //         ],
          //       )

          //   );
          //   // val = val+'\n' +'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ ';
          //   // val =

          //   // tmp += '\n'+val;

          //   // val = tmp;
          // }
          // else if(index == 0){
          //   return Container(
          //       child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.end,
          //     children: [
          //       Text(
          //         'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ ',
          //         style: TextStyle(
          //           fontFamily: 'arabic1',
          //           fontSize: 50,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ],
          //   ));
          // }
          return Card(
            elevation: 3,
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xFFf1eee4),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    val,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'arabic1',
                        fontSize: 32,
                        fontWeight:
                            (val == "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ")
                                ? FontWeight.bold
                                : FontWeight.normal),
                  ),
                  // Text(val+"   (${numNum})   ",
                  // style: TextStyle(
                  //   fontFamily: 'arabic1',
                  //   fontSize: 30,
                  // ),
                  // softWrap: true,
                  // textDirection: TextDirection.rtl,),
                ],
              ),
            ),
          );
          // val = val.replaceRange(39, val.length, '')+"بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيم\n ";
        },
      )),
    );
  }
}

// import 'package:flutter/material.dart';

class CircleNumber extends StatelessWidget {
  final int number;
  final double circleSize;
  final TextStyle textStyle;
  final Color circleColor;

  CircleNumber({
    required this.number,
    this.circleSize = 30.0,
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 16),
    this.circleColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        color: circleColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: textStyle,
        ),
      ),
    );
  }
}
