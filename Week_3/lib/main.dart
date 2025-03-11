import 'package:flutter/material.dart';
import 'package:week_3/theme_changer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isThemeMode = true;

  ThemeData lightThem = ThemeData(
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      textTheme: const TextTheme(
        bodySmall: TextStyle(color: Colors.black, fontSize: 50),
      ));
  ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      textTheme: const TextTheme(
        bodySmall: TextStyle(color: Colors.red),
      ));
  @override
  Widget build(BuildContext context) {
    print(isThemeMode);
    return MaterialApp(
        theme: isThemeMode ? lightThem : darkTheme,
        title: 'Flutter Demo',
        home: ThemeChanger(
          isTheme: isThemeMode,
          onChanged: (value) {
            isThemeMode = value;
            setState(() {});
            print(value);
          },
        ));
  }
}
