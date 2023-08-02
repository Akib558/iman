import 'package:flutter/material.dart';

class ButtonPage extends StatelessWidget {
  final String image;
  const ButtonPage({super.key,
  required this.image,});

  @override
  Widget build(BuildContext context) {
    return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              // margin: EdgeInsets.all(20),
                              
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 215, 216, 215),
                                
                            
                              ),
                              child: Image.asset(image)
                              ),
                          ),
                        );
  }
}