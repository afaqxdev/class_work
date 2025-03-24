import 'package:get/state_manager.dart';

class CounterContoller extends GetxController {
  int counter = 0;

  void increment() {
    counter++;
    update();
  }

  RxInt counter2 = 0.obs;
  void increment2() {
    counter2++;
  }
}
