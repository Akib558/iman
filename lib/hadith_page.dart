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
        return SizedBox(
          height: 200, // Adjust the height as needed
          child: Column(
            children: [
              // Content for your pop-up section
              const Text('This is the pop-up section content.'),
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
                        child: const Text("Arabic")),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            lang = 1;
                          });
                        },
                        child: const Text("Bangla")),
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
    final metadataSections = metadata["sections"];
    Map<String, dynamic> metadataSectionsDetails = metadata["section_details"];
    List<dynamic> hadiths = ara_bukhari[0]["hadiths"] as List<dynamic>;
    List<String> metadataSectionsList = [];
    metadataSections.forEach((key, value) {
      metadataSectionsList.add(value);
    });

    // //print(hadiths[0]["text"]);
    //print(metadata_sections_details["0"]["hadithnumber_first"]);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hadith"),
      ),
      body: Container(
        // padding: ,
        child: ListView.builder(
          itemCount: metadataSectionsList.length,
          itemBuilder: (context, index) {
            if (index > 0) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return HadithDetailsPage(
                          hadithnumberfirst: metadataSectionsDetails["$index"]
                              ["hadithnumber_first"],
                          hadithnumberlast: metadataSectionsDetails["$index"]
                              ["hadithnumber_last"],
                        );
                      },
                    ),
                  );
                },
                child: Card(
                  elevation: 3,
                  child: Container(
                    padding: const EdgeInsets.all(10),
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
                                child: Text(
                                  metadataSectionsList[index],
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
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
