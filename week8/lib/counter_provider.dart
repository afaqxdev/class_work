import 'package:flutter/material.dart';

class CounterProvide with ChangeNotifier {
  int counter = 0;

  void incrementCounter(int value) {
    counter=value;
    notifyListeners();
  }
}
