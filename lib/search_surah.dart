import 'package:flutter/material.dart';
import 'package:prayer_app/surah_name.dart';
import 'package:prayer_app/surah_page.dart';

class SearchSurah extends StatefulWidget {
  const SearchSurah({super.key});

  @override
  State<SearchSurah> createState() => _SearchSurahState();
}

class _SearchSurahState extends State<SearchSurah> {
  List<String> dropdownItems1 = ['(1) Al-Fatiha'];
  List<String> dropdownItems2 = ['1'];
  List<String> dropdownItems3 = ['1'];

  String selectedItem1 = '(1) Al-Fatiha';
  String selectedItem2 = '1';
  String selectedItem3 = '1';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i = 1; i < surahNames.length; i++) {
      String dd = surahNames[i]["title"] as String;
      dropdownItems1.add("(${i + 1}) $dd");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Ayah'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<String>(
                    value: selectedItem1,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedItem1 = newValue!;
                        // //print(selectedItem1);
                        dropdownItems2 = ['1'];
                        int index = int.parse(selectedItem1[1]);
                        int totalAyah = surahNames[index - 1]["count"] as int;
                        for (var i = 2; i <= totalAyah; i++) {
                          dropdownItems2.add("$i");
                        }
                      });
                    },
                    items: dropdownItems1
                        .map<DropdownMenuItem<String>>((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    value: selectedItem2,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedItem2 = newValue!;
                        dropdownItems3 = ['1'];
                        int index = int.parse(selectedItem1[1]);
                        int totalAyah = surahNames[index - 1]["count"] as int;
                        for (var i = 2; i <= totalAyah; i++) {
                          dropdownItems3.add("$i");
                        }
                      });
                    },
                    items: dropdownItems2
                        .map<DropdownMenuItem<String>>((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    value: selectedItem3,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedItem3 = newValue!;
                      });
                    },
                    items: dropdownItems3
                        .map<DropdownMenuItem<String>>((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle form submission here
                  int val1 = int.parse(selectedItem1[1]);
                  int val2 = int.parse(selectedItem2);
                  int val3 = int.parse(selectedItem3);
                  //print(val1);
                  //print(val2);
                  //print(val3);

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        // return SurahPage(surahNumber:val['number'].toString());
                        return SurahPage(
                          surahNumber: val1.toString(),
                          from_search: true,
                          surah_start_index: val2,
                          surah_end_index: val3,
                        );
                      },
                    ),
                  ).then(
                    (value) => {
                      setState(() {
                        dropdownItems1 = ['(1) Al-Fatiha'];
                        dropdownItems2 = ['1'];
                        dropdownItems3 = ['1'];
                        for (var i = 1; i < surahNames.length; i++) {
                          String dd = surahNames[i]["title"] as String;
                          dropdownItems1.add("(${i + 1}) $dd");
                        }
                        selectedItem1 = '(1) Al-Fatiha';
                        selectedItem2 = '1';
                        selectedItem3 = '1';
                      })
                    },
                  );
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
