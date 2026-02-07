import 'package:flutter/material.dart';
// import 'package:flutter/prayer_app/../nameOfAllah.dart';
import 'package:prayer_app/importanFiles/nameOfAllah.dart';

class NameOfAllah extends StatefulWidget {
  const NameOfAllah({super.key});

  @override
  State<NameOfAllah> createState() => _NameOfAllahState();
}

class _NameOfAllahState extends State<NameOfAllah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Name of Allah's"),
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: ListView.builder(
          itemCount: nameOfAllah.length,
          itemBuilder: (context, index) {
            // index += 12;
            String nameArabic = nameOfAllah[index]['arabic'] as String;
            String nameEnglish = nameOfAllah[index]['english'] as String;
            String meaningEnglish =
                nameOfAllah[index]['englishmeaning'] as String;
            String nameBangla = nameOfAllah[index]['bangla'] as String;
            String meaningbangla =
                nameOfAllah[index]['banglameaning'] as String;

            return Card(
              elevation: 3,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xFFf1eee4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nameArabic,
                          style: const TextStyle(
                            fontFamily: 'arabic1',
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          nameEnglish,
                          style: const TextStyle(fontSize: 15),
                        ),
                        Text(
                          nameBangla,
                          style: const TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                    // Spacer(),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.end,
                    //   children: [
                    //     Text(meaningEnglish),
                    //     Text(meaningbangla),
                    //   ],
                    // )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
