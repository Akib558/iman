import 'package:flutter/material.dart';

class ButtonPage extends StatelessWidget {
  final String image;
  final String name;
  const ButtonPage({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        // margin: EdgeInsets.all(20),
        padding: const EdgeInsets.all(5),
        // width: double.infinity,
        height: 70,

        // margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
        // padding: EdgeInsets.fromLTRB(120, 5, 120, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFf1eee4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image(
                image: AssetImage(image),
                width: 40,
                height: 40,
              ),
            ),
            // Image.asset(
            // image,

            // ),
            Flexible(
                child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ))
          ],
        ),
      ),
    );
  }
}
