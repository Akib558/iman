import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class FullQuran extends StatelessWidget {
  const FullQuran({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Quran"),
      ),
      body: 
      ListView.builder(
              itemCount: 604,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // margin: EdgeInsets.all(20),
                    // width: double.infinity,
                    height: screenHeight,
                    width: screenWidth,
                
                    // margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Center(
                      child: Image.asset("assets/images/quran_images/${index+1}.png",
                      // fit: BoxFit.fitHeight,
                      width: screenWidth-20,
                      ),
                    ),
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(20),
                    //   color: Colors.red,
                    // ),
                  ),
                );
              },
            )
    );
  }
}
