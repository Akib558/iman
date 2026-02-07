import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:prayer_app/hadith_page.dart';
import 'package:prayer_app/names.dart';
import 'package:prayer_app/prayer_time.dart';
import 'package:prayer_app/quran_page.dart';
import 'package:prayer_app/full_quran.dart';
import 'package:prayer_app/search_surah.dart';
import 'package:prayer_app/tasbih_page.dart';
// import 'package:provider/provider.dart';
import 'package:prayer_app/button_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double ele = 4;
  // var myBox;
  // var demo;
  int dd = 1;
  int pp = 0;

  final myBox = Hive.box('DB1');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //print("inside homepage init");
  }

  @override
  Widget build(BuildContext context) {
    // if (dd == 1) {
    //   setState(() {});
    // }
    // var myBox = Hive.box("DB1");
    List<dynamic> demo = [0, "Al-Fatiha"];
    if (myBox.get("quran_index") != null) {
      demo = myBox.get("quran_index");
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 77, 78),
        title: const Text(
          "Iman",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            // color: Colors.white,
          ),
        ),
      ),
      body: Container(
        // padding: EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 0, 89, 90),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    // // height: 300,
                    // padding: EdgeInsets.all(100),
                    decoration: const BoxDecoration(
                        // color: Color.fromARGB(0, 255, 23, 23),
                        ),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              // margin: EdgeInsets.all(20),
                              // width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // color: Color.fromARGB(255, 20, 255, 20),
                              ),

                              // margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                              // padding: EdgeInsets.fromLTRB(120, 5, 120, 5),
                              child: Image.asset(
                                'assets/images/quran_2.png',
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                demo[1] as String,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Text("Page : ${demo[0]}"),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all<
                                            Color>(
                                        const Color.fromARGB(255, 0, 77, 78))),
                                onPressed: () {
                                  dd = 1;
                                  // //print("before full quran");
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const FullQuran(
                                          fromHome: true,
                                        );
                                      },
                                    ),
                                  ).then(
                                    (value) {
                                      setState(() {
                                        //print("hello 1");
                                      });
                                    },
                                  );
                                },
                                child: const Text(
                                  "Continue Reading",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.star,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: GestureDetector(
                              child: const ButtonPage(
                                  image: 'assets/images/quran.png',
                                  name: 'Quran & Juz'),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const QuranPage();
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 2.5, 2.5, 2.5),
                                  child: GestureDetector(
                                    child: const ButtonPage(
                                        image: 'assets/images/quran.png',
                                        name: 'Full Quran'),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const FullQuran(
                                              fromHome: false,
                                            );
                                          },
                                        ),
                                      ).then(
                                        (value) {
                                          setState(() {
                                            //print("hello 1");
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      2.5, 2.5, 0, 2.5),
                                  child: GestureDetector(
                                    child: const ButtonPage(
                                        image: 'assets/images/prayer.png',
                                        name: 'Prayer Time'),
                                    onTap: () {
                                      //print('its working');
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const PrayerTime();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 2.5, 2.5, 2.5),
                                  child: GestureDetector(
                                    child: const ButtonPage(
                                        image: 'assets/images/names.png',
                                        name: 'Allah\'s Name'),
                                    onTap: () {
                                      //print('its working');
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const NameOfAllah();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      2.5, 2.5, 0, 2.5),
                                  child: GestureDetector(
                                    child: const ButtonPage(
                                        image: 'assets/images/hadith.png',
                                        name: 'Hadiths'),
                                    onTap: () {
                                      //print('its working');
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const HadithPage();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 2.5, 2.5, 2.5),
                                  child: GestureDetector(
                                    child: const ButtonPage(
                                        image: 'assets/images/tasbih.png',
                                        name: 'Tasbih'),
                                    onTap: () {
                                      //print('its working');
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const TasbihPage();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      2.5, 2.5, 0, 2.5),
                                  child: GestureDetector(
                                    child: const ButtonPage(
                                        image: 'assets/images/search.png',
                                        name: 'Search Ayah'),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const SearchSurah();
                                          },
                                        ),
                                      );
                                      //print('its working');
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //     iconSize: 25,
      //     selectedFontSize: 10,
      //     unselectedFontSize: 10,
      //     // backgroundColor: Colors.blue,
      //     type: BottomNavigationBarType.fixed,
      //     // fixedColor: Colors.red,
      //     unselectedItemColor: const Color.fromARGB(255, 108, 108, 108),

      //     // currentIndex: HomePage(),
      //     // // onTap: (value){
      //     // //   setState(() {
      //     // //     currentPage = value;
      //     // //   });
      //     // // },
      //     items: [
      //       BottomNavigationBarItem(
      //         icon: Image.asset(
      //           'assets/images/quran.png',
      //           height: 30,
      //           width: 30,
      //         ),
      //         label: 'Quran',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Image.asset(
      //           'assets/images/quran.png',
      //           height: 30,
      //           width: 30,
      //         ),
      //         label: 'Explore',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: 'Home',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.shopping_cart),
      //         label: 'Duas',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: 'Notes',
      //       ),
      //     ]),
    );
  }
}
