import 'package:bachelor_heaven/constants/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bachelor Heaven'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(currentDate, style: TextStyle(fontSize: 18)),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'Hello, ',
                  style: TextStyle(color: Colors.grey, fontSize: 16)),
              TextSpan(
                  text: 'Pritom Shajed',
                  style: TextStyle(color: Colors.grey, fontSize: 16)),
            ]))
          ],
        ),
      ),
    );
  }
}
