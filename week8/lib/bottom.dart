import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8/counter_provider.dart';
import 'package:week8/home.dart';

class BottomNaviagtionScreen extends StatelessWidget {
  BottomNaviagtionScreen({super.key});
  int selectIndex = 0;

  List<Widget> screens = [
    MyHomePage(title: 'Home Page'),
    Container(
      child: Text("Screen 2"),
    ),
    Container(
      child: Text("Screen 3"),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final providerClassData =
        Provider.of<CounterProvide>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bottom Navigation'),
        ),
        body: Consumer<CounterProvide>(builder: (context, providerData, child) {
          return screens[providerClassData.counter];
        }),
        bottomNavigationBar:
            Consumer<CounterProvide>(builder: (context, providerData, child) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed, // Ensures color change

            onTap: (value) {
              selectIndex = value;
              providerClassData.incrementCounter(value);
              print(value);
            },
            currentIndex: providerClassData.counter,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.yellow, // Color of unselected items

            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Screen1',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile')
            ],
          );
        })
        
        
        );
  }
}
