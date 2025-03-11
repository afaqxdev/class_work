// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class AnimatedPaddingScreen extends StatefulWidget {
  const AnimatedPaddingScreen({super.key});

  @override
  State<AnimatedPaddingScreen> createState() => _AnimatedPaddingScreenState();
}

class _AnimatedPaddingScreenState extends State<AnimatedPaddingScreen> {
  bool isAnimated = false;

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text("data"),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: Container(
        width: 50,
        height: 50,
        color: Colors.white,
        child: IconButton(
            onPressed: () {
              isAnimated = !isAnimated;
              setState(() {});
            },
            icon: const Icon(Icons.add)),
      ),
      body: Column(
        children: [
          AnimatedPadding(
            padding: EdgeInsets.only(
                top: isAnimated ? 100 : 0, right: isAnimated ? 100 : 0),
            duration: const Duration(seconds: 3),
            child: const FlutterLogo(
              size: 200,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
