import 'package:flutter/material.dart';

class SliderProvider with ChangeNotifier {
  double silderValue = 1;

  void changeInSliderValue(double value) {
    silderValue = value;
    notifyListeners();
  }
}
