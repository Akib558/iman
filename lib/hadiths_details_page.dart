import 'package:flutter/material.dart';
import 'package:prayer_app/importanFiles/ara-bukhari.dart';
import 'package:prayer_app/importanFiles/ben-bukhari.dart';
import 'package:prayer_app/importanFiles/eng-bukhari.dart';

class HadithDetailsPage extends StatefulWidget {
  final int hadithnumberfirst;
  final int hadithnumberlast;
  const HadithDetailsPage(
      {super.key,
      required this.hadithnumberfirst,
      required this.hadithnumberlast});

  @override
  State<HadithDetailsPage> createState() => _HadithDetailsPageState();
}

class _HadithDetailsPageState extends State<HadithDetailsPage> {
  late int h_f;
  late int h_l;
  int lang = 3;
  bool isPopupVisible = false;

  GestureDetector selectLang(int val, String optionName) {
    return GestureDetector(
        onTap: () {
          setState(() {
            lang = val;
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
        return SizedBox(
          height: 100,
          width: double.infinity, // Adjust the height as needed
          child: Column(
            children: [
              // Content for your pop-up section
              const Text(
                'Select Language',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  selectLang(0, "Arabic"),
                  selectLang(1, "Bangla"),
                  selectLang(2, "English"),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }

  String hadithText(int index, int lang) {
    String val = "";
    RegExp arabicPattern = RegExp(
        r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]');
    if (lang == 0) {
      val = hadiths0[index + h_f]["text"];
    } else if (lang == 1) {
      val = hadiths1[index + h_f]["text"];
      val = val.replaceAll(arabicPattern, '');
    } else {
      val = hadiths2[index + h_f]["text"];
      val = val.replaceAll(arabicPattern, '');
    }
    return val;
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

  @override
  void initState() {
    super.initState();
    h_f = widget.hadithnumberfirst;
    h_l = widget.hadithnumberlast;
  }

  List<dynamic> hadiths0 = ara_bukhari[0]["hadiths"] as List<dynamic>;
  List<dynamic> hadiths1 = ben_bukhari[0]["hadiths"] as List<dynamic>;
  List<dynamic> hadiths2 = eng_bukhari[0]["hadiths"] as List<dynamic>;

  @override
  Widget build(BuildContext context) {
    // print(hadiths);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hadith Section"),
      ),
      body: ListView.builder(
        itemCount: h_l - h_f,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showPopup(context);
            },
            onLongPress: () {
              // showPopup(context);
            },
            child: Card(
              elevation: 3,
              child: Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFf1eee4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Center(
                              child: Text(
                                // metadata_sections_list[index],
                                hadithText(index, lang),
                                // lang == 0
                                //     ? hadiths0[index + h_f]["text"]
                                //     : hadiths1[index + h_f]["text"],
                                style: TextStyle(
                                  fontFamily: langSettings(lang),
                                  fontSize: 20,
                                ),
                                // textDirection: TextDirection.rtl,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
