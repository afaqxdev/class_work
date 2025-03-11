// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AnimatedPositionScreen extends StatefulWidget {
  const AnimatedPositionScreen({super.key});

  @override
  State<AnimatedPositionScreen> createState() => _AnimatedPositionScreenState();
}

class _AnimatedPositionScreenState extends State<AnimatedPositionScreen> {
  bool ischangePostion = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: IconButton(
            onPressed: () {
              ischangePostion = !ischangePostion;
              setState(() {});
              print(ischangePostion);
            },
            icon: const Icon(
              Icons.ac_unit,
              size: 50,
            )),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                ischangePostion
                    ? Container(
                        width: 100,
                        height: 100,
                        color: Colors.amber,
                      )
                    : Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle)),
                AnimatedCrossFade(
                    firstChild: Container(
                      width: 100,
                      height: 100,
                      color: Colors.amber,
                    ),
                    secondChild: Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle)),
                    crossFadeState: ischangePostion
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: Durations.extralong1),
                Container(
                  width: ischangePostion ? 150 : 100,
                  height: 100,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 30,
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 3),
                  width: ischangePostion ? 150 : 100,
                  curve: Curves.easeInCirc,
                  height: 100,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ));
  }
}
// Stack(children: [
      //   Positioned(
      //       top: 100,
      //       child: Image.asset(
      //         'class_week/only_d.png',
      //         scale: 4,
      //       )),
      //   AnimatedPositioned(
      //       top: ischangePostion ? 200 : 300,
      //       left: ischangePostion ? 100 : 0,
      //       curve: Curves.bounceInOut,
      //       duration: const Duration(seconds: 2),
      //       child: Visibility(
      //           visible: ischangePostion,
      //           child: Image.asset(
      //             'class_week/fork.png',
      //             color: Colors.amber,
      //             scale: 5,
      //           ))),
      // ]),