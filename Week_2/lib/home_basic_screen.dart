import 'package:flutter/material.dart';
import 'package:week_2/home_screen/mobile_screen.dart';
import 'package:week_2/home_screen/pc_screen.dart';
import 'package:week_2/home_screen/tablet_screen.dart';

class HomeBasic extends StatefulWidget {
  const HomeBasic({super.key});

  @override
  State<HomeBasic> createState() => _HomeBasicState();
}

class _HomeBasicState extends State<HomeBasic> {
  bool iCheckMark = false;

  @override
  Widget build(BuildContext context) {
    print("Im working ");
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 450) {
          return const HomeScreenTablet();
        } else if (constraints.maxWidth > 850) {
          return const HomeScreenPC();
        }
        return const HomeScreenMobile();
      },
    );
  }
}
