import 'package:flutter/material.dart';

class TasbihCounter extends StatefulWidget {
  final String dhikirDhikir;
  final String dhikirTranslationEn;
  const TasbihCounter(
      {super.key,
      required this.dhikirDhikir,
      required this.dhikirTranslationEn});

  @override
  State<TasbihCounter> createState() => _TasbihCounterState();
}

class _TasbihCounterState extends State<TasbihCounter> {
  late String dhikirName;
  late String dhikirTranslationEn;

  int cnt = 0;

  @override
  void initState() {
    super.initState();
    dhikirName = widget.dhikirDhikir;
    dhikirTranslationEn = widget.dhikirTranslationEn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasbih Counter"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                dhikirName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    cnt++;
                  });
                },
                child: Container(
                    // padding: EdgeInsets.all(300),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(150, 100, 150, 100),
                      child: Center(
                        child: Text(
                          cnt.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                              color: Colors.white),
                        ),
                      ),
                    ))),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          cnt = 0;
                        });
                      },
                      child: const Text(
                        "Reset",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Close",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
