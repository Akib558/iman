import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:prayer_app/combined_output.dart';

// String surah='1';

class SurahPage extends StatefulWidget {
  final String surahNumber;
  const SurahPage({
    super.key,
    required this.surahNumber,
  });

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  late Future<Map<String, dynamic>> surahlist;
  // late String surah;
  // late List<dynamic> mainlist;
  // surah = "114";
  Future<Map<String, dynamic>> getSurahFull() async {
    try {
      // String cityName = 'Dhaka';
      String demo = "http://api.alquran.cloud/v1/surah/";
      // demo += number.toString();
      demo += widget.surahNumber;
      demo += "/ar.asad";
      print(
          '---------------=======================-----------------------------------------------------');
      print(demo);
      print(
          '---------------=======================-----------------------------------------------------');

      final res = await http
          // .get(Uri.parse('http://api.alquran.cloud/v1/surah/{surahNumber}/ar.asad'));
          .get(Uri.parse(demo));

      final data = jsonDecode(res.body);
      if (data['code'] != 200) {
        throw "An unexpected errorrrrrrrrrrrrr";
      }

      // print(data["data"][0]);
      // print(data["data"][1]);
      // print(data["data"][2]);

      // mainlist = data['data'];

      return data;

      // print(data['list'][0]['main']['temp']);

      // temp = data['list'][0]['main']['temp'] - 273;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // surah = surahNumber;
    surahlist = getSurahFull();
    // print(mainlist[0]);
    // mainlist = surahlist['data'];
    // print(surahlist['data'][0]);
  }

  Widget build(BuildContext context) {
    // surah = widget.surahNumber;
    return Scaffold(
      appBar: AppBar(
        title: Text('HELLO'),
      ),
      body: Container(
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


            final surahIndex = int.parse(widget.surahNumber)-1;
            Map<String, dynamic> verses = allSurahs[surahIndex]["verse"] as Map<String, dynamic>;

            List<String> verseValues = [];
            verses.forEach((key, value) {
            verseValues.add(value);
            });

            print(verseValues);



            final data = snapshot.data!;
            final mainlist = data['data']['ayahs'];
            // final Map<String, dynamic> mainlist = data['data'];
            // print(mainlist[0]['text']);
            // print("بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ ".length);
            // return Placeholder();
            return ListView.builder(
              itemCount: mainlist.length,
              itemBuilder: (context, index) {
                
                String val = verseValues[index];
                int numNum = index;

                // String val = mainlist[index]['text'];
                // int numNum = mainlist[index]['numberInSurah'];
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
                return Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 227, 227, 227),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'arabic1',
                                fontSize: 30,
                                // color: Colors.black
                              ),
                            
                              children: <TextSpan>[
                                TextSpan(text: val, style: TextStyle(color: Colors.black)),
                                TextSpan(text:"        (${numNum})      ", 
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold
                                  )),
                              ]
                            ),
                          ),
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
                );
                // val = val.replaceRange(39, val.length, '')+"بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيم\n ";
              },
            );
          },
        ),
      ),
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
