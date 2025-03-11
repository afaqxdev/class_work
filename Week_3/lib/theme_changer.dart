import 'package:flutter/material.dart';

class ThemeChanger extends StatefulWidget {
  ThemeChanger({super.key, required this.isTheme, required this.onChanged});
  bool isTheme = true;
  void Function(bool)? onChanged;
  @override
  State<ThemeChanger> createState() => _ThemeChangerState();
}

class _ThemeChangerState extends State<ThemeChanger> {
  @override
  Widget build(BuildContext context) {
    print("refresh build");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "data",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Center(
              child: Switch(
                value: widget.isTheme,
                onChanged: widget.onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
