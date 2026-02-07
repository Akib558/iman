import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:prayer_app/tasbih_counter.dart';
import 'package:prayer_app/importanFiles/dhikirList.dart';

class TasbihPage extends StatefulWidget {
  const TasbihPage({super.key});

  @override
  State<TasbihPage> createState() => _TasbihPageState();
}

class _TasbihPageState extends State<TasbihPage> {
  final myBox = Hive.box("DB1");
  late List<dynamic> dhikir;
  // String _inputValue = '';
  // final TextEditingController _textController = TextEditingController();

  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _textController3 = TextEditingController();
  String _inputValue1 = '';
  String _inputValue2 = '';
  String _inputValue3 = '';

  void _showDialog(BuildContext context, String initialValue1,
      String initialValue2, String initialValue3, int func, int indexVal) {
    _textController1.text = initialValue1;
    _textController2.text = initialValue2;
    _textController3.text = initialValue3;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Input Dialog'),
          content: Column(
            children: <Widget>[
              TextFormField(
                controller: _textController1,
                decoration: const InputDecoration(
                  hintText: 'Dhikir',
                ),
              ),
              TextFormField(
                controller: _textController2,
                decoration: const InputDecoration(
                  hintText: 'Englist Translation',
                ),
              ),
              TextFormField(
                controller: _textController3,
                decoration: const InputDecoration(
                  hintText: 'Bangla Translation',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (func == 0) {
                    _inputValue1 = _textController1.text;
                    _inputValue2 = _textController2.text;
                    _inputValue3 = _textController3.text;

                    dhikir.add({
                      "id": "1",
                      "dhikir": _inputValue1,
                      "arabic": _inputValue2,
                      "translationEn": _inputValue3,
                      "translationBn": _inputValue3
                    });
                    myBox.delete("dhikirList");
                    myBox.put("dhikirList", dhikir);
                    _textController1.clear();
                    _textController2.clear();
                    _textController3.clear();
                  } else {
                    _inputValue1 = _textController1.text;
                    _inputValue2 = _textController2.text;
                    _inputValue3 = _textController3.text;

                    dhikir = myBox.get("dhikirList");
                    dhikir[indexVal]["id"] = _inputValue1;
                    dhikir[indexVal]["dhikir"] = _inputValue1;
                    dhikir[indexVal]["arabic"] = _inputValue2;
                    dhikir[indexVal]["translationEn"] = _inputValue3;
                    dhikir[indexVal]["translationBn"] = _inputValue3;
                    myBox.delete("dhikirList");
                    myBox.put("dhikirList", dhikir);
                  }
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (myBox.get("dhikirList") == null) {
      myBox.put("dhikirList", dhikirList);
    }
    dhikir = myBox.get("dhikirList") as List<dynamic>;
    //print("=========================${dhikir}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasbih"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: dhikir.length,
          itemBuilder: (context, index) {
            String dhikirId = dhikir[index]["id"];
            String dhikirDhikir = dhikir[index]["dhikir"];
            String dhikirArabic = dhikir[index]["arabic"];
            String dhikirTranslationEn = dhikir[index]["translationEn"];
            String dhikirTranslationBn = dhikir[index]["translationBn"];

            return Card(
                child: Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return TasbihCounter(
                                  dhikirDhikir: dhikirDhikir,
                                  dhikirTranslationEn: dhikirTranslationEn,
                                );
                              }));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                dhikirDhikir,
                                style: const TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Spacer(),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  _showDialog(context, '0', dhikirDhikir,
                                      dhikirTranslationEn, 1, index);
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: Color.fromARGB(255, 10, 194, 16),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    dhikir.removeAt(index);
                                    myBox.put("dhikirList", dhikir);
                                  });
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Color.fromARGB(255, 243, 25, 10),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF00595a),
        onPressed: () {
          _showDialog(context, '', '', '', 0, 0);
        },
        child: const Center(
          child: Text(
            "+",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
