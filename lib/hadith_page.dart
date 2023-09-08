import 'package:flutter/material.dart';
import 'package:prayer_app/hadiths_details_page.dart';
import 'package:prayer_app/importanFiles/ara-bukhari.dart';

class HadithPage extends StatefulWidget {
  const HadithPage({super.key});

  @override
  State<HadithPage> createState() => _HadithPageState();
}

class _HadithPageState extends State<HadithPage> {
  // final data = ara_bukhari[0]["metadata"]["sections"]!;
  // Map<String, dynamic>? araBukharSectionsiList =
  //     ara_bukhari[0]["metadata"]["sections"];
  bool isPopupVisible = false;
  int lang = 1;

  void showPopup(BuildContext context) {
    setState(() {
      isPopupVisible = true;
    });

    // show
    showDialog(
      // showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200, // Adjust the height as needed
          child: Column(
            children: [
              // Content for your pop-up section
              Text('This is the pop-up section content.'),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the pop-up section
                },
                child: Container(
                  child: Column(children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            lang = 0;
                          });
                        },
                        child: Text("Arabic")),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            lang = 1;
                          });
                        },
                        child: Text("Bangla")),
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic>? araBukharSectionsiList = ara_bukhari[0];
    Map<String, dynamic> metadata =
        ara_bukhari[0]["metadata"] as Map<String, dynamic>;
    final metadata_sections = metadata["sections"];
    Map<String, dynamic> metadata_sections_details =
        metadata["section_details"];
    List<dynamic> hadiths = ara_bukhari[0]["hadiths"] as List<dynamic>;
    List<String> metadata_sections_list = [];
    metadata_sections.forEach((key, value) {
      metadata_sections_list.add(value);
    });

    // //print(hadiths[0]["text"]);
    //print(metadata_sections_details["0"]["hadithnumber_first"]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Hadith"),
      ),
      body: Container(
        // padding: ,
        child: ListView.builder(
          itemCount: metadata_sections_list.length,
          itemBuilder: (context, index) {
            if (index > 0) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return HadithDetailsPage(
                          hadithnumberfirst: metadata_sections_details["$index"]
                              ["hadithnumber_first"],
                          hadithnumberlast: metadata_sections_details["$index"]
                              ["hadithnumber_last"],
                        );
                      },
                    ),
                  );
                },
                child: Card(
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  metadata_sections_list[index],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFf1eee4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
