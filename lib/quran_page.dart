import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:prayer_app/surah_page.dart';


class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {

  late Future<Map<String,dynamic>> surahlist;
  // late List<dynamic> mainlist;
  Future<Map<String, dynamic>> getQuranFull() async {
    try {
      // String cityName = 'Dhaka';
      final res = await http.get(Uri.parse(
          'http://api.alquran.cloud/v1/surah'));

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
    surahlist = getQuranFull();
    // print(mainlist[0]);
    // mainlist = surahlist['data'];
    // print(surahlist['data'][0]);
  }


  Widget build(BuildContext context) {
    print(surahlist);
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
      ),
      body: FutureBuilder(
        future: surahlist,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 0, 0, 0), strokeWidth: 10, ));
          }
          final data = snapshot.data!;
          final mainlist = data['data'];
          // final Map<String, dynamic> mainlist = data['data'];
          print(mainlist);
          return ListView.builder(
            itemCount: mainlist.length,
            itemBuilder: (context, index) {
              final val = mainlist[index];
              return Container(
                padding: EdgeInsets.fromLTRB(10,5,10,5),
                // decoration: BoxDecoration(

                
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return SurahPage(surahNumber:val['number'].toString());
                          },
                        ),
                    );
                  },
                  child: Container(
                    
                    // tr: MainAxisAlignment.start,                    // height: 50,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 186, 184, 184),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(val['number'].toString()+'. ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                                Text('')
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(val['englishName'],
                                style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),),
                                Text(val['numberOfAyahs'].toString()+' verses'),

                              ],
                            ),
                            Spacer(),
                            Text(val['name'],
                            style: TextStyle(
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
    );
  }
}