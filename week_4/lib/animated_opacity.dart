// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool isOpacity = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              duration: const Duration(seconds: 3),
              curve: Curves.bounceOut,
              opacity: isOpacity ? 0.3 : 1.0,
              child: const FlutterLogo(
                size: 200,
              ),
            ),
            IconButton(
                onPressed: () {
                  isOpacity = !isOpacity;
                  print("working");

                  setState(() {});
                },
                icon: const Icon(Icons.circle_notifications))
          ],
        ),
      ),
    );
  }
}
