import 'package:flutter/material.dart';

class CounterProvider2 with ChangeNotifier {
  double counterNo = 1.0;
  double fontSize = 20;
  void incrementCounter() {
    counterNo++;
    notifyListeners();
  }

  void increaseFontSize(double size) {
    fontSize = size;
    notifyListeners();
  }
}
