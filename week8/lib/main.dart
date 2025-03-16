import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8/bottom.dart';
import 'package:week8/continer_provider.dart';
import 'package:week8/counter_provider.dart';
import 'package:week8/counter_provider2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvide()),
        ChangeNotifierProvider(create: (context) => SliderProvider()),
        ChangeNotifierProvider(create: (context) => CounterProvider2())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: BottomNaviagtionScreen()),
    );
  }
}
