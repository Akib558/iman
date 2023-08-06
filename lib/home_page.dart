import 'package:flutter/material.dart';
import 'package:prayer_app/quran_page.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:prayer_app/button_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double ele = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 0, 89, 90),
          ),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                // decoration: BoxDecoration(
                //   color: Color.fromARGB(255, 24, 202, 170),
                // ),
                // margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Deen",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          // color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // height: 300,
                padding: EdgeInsets.all(100),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(0, 255, 255, 255),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(child: Text('hello')),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
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
                          padding: const EdgeInsets.fromLTRB(0, 20, 0 , 0),
                          child: GestureDetector(
                            child: Material(
                              elevation: ele,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                // margin: EdgeInsets.all(20),
                                // width: double.infinity,
                                height: 70,
                                
                                // margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                                padding: EdgeInsets.fromLTRB(120, 5, 120, 5),
                                child: Image.asset('assets/images/quran.png',),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 215, 216, 215),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return QuranPage();
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
                                padding: const EdgeInsets.fromLTRB(0, 2.5, 2.5, 2.5),
                                child: GestureDetector(
                                  child: Material(
                                    elevation: ele,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      // margin: EdgeInsets.all(20),
                                      // width: double.infinity,
                                      height: 70,
                                      
                                      // margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                                      child: Image.asset('assets/images/quran.png'),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color.fromARGB(255, 215, 216, 215),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    print('its working');
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(2.5,2.5,0,2.5),
                                child: GestureDetector(
                                  child: Material(
                                    elevation: ele,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      // margin: EdgeInsets.all(20),
                                      // width: double.infinity,
                                      height: 70,
                                      
                                      // margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                                      child: Image.asset('assets/images/quran.png'),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color.fromARGB(255, 215, 216, 215),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    print('its working');
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
                                padding: const EdgeInsets.fromLTRB(0, 2.5, 2.5, 2.5),
                                child: GestureDetector(
                                  child: Material(
                                    elevation: ele,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      // margin: EdgeInsets.all(20),
                                      // width: double.infinity,
                                      height: 70,
                                      
                                      // margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                                      child: Image.asset('assets/images/quran.png'),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color.fromARGB(255, 215, 216, 215),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    print('its working');
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(2.5,2.5,0,2.5),
                                child: GestureDetector(
                                  child: Material(
                                    elevation: ele,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      // margin: EdgeInsets.all(20),
                                      // width: double.infinity,
                                      height: 70,
                                      
                                      // margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                                      child: Image.asset('assets/images/quran.png'),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color.fromARGB(255, 215, 216, 215),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    print('its working');
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
                                padding: const EdgeInsets.fromLTRB(0, 2.5, 2.5, 2.5),
                                child: GestureDetector(
                                  child: Material(
                                    elevation: ele,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      // margin: EdgeInsets.all(20),
                                      // width: double.infinity,
                                      height: 70,
                                      
                                      // margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                                      child: Image.asset('assets/images/quran.png'),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color.fromARGB(255, 215, 216, 215),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    print('its working');
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(2.5,2.5,0,2.5),
                                child: GestureDetector(
                                  child: Material(
                                    elevation: ele,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      // margin: EdgeInsets.all(20),
                                      // width: double.infinity,
                                      height: 70,
                                      
                                      // margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                                      child: Image.asset('assets/images/quran.png'),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color.fromARGB(255, 215, 216, 215),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    print('its working');
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        // backgroundColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        // fixedColor: Colors.red,
        unselectedItemColor: const Color.fromARGB(255, 108, 108, 108),
        
        // currentIndex: HomePage(),
        // // onTap: (value){
        // //   setState(() {
        // //     currentPage = value;
        // //   });
        // // },
        items: [
          BottomNavigationBarItem(icon: Image.asset('assets/images/quran.png', height: 30, width: 30,),
          label: 'Quran',),
          BottomNavigationBarItem(icon: Image.asset('assets/images/quran.png', height: 30, width: 30,),
          label: 'Explore',),
          BottomNavigationBarItem(icon: Icon(Icons.home),
          label: 'Home',),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),
          label: 'Duas',),
          BottomNavigationBarItem(icon: Icon(Icons.home),
          label: 'Notes',),
          ]),
    );
  }
}
