import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8/continer_provider.dart';

class CustomContainer extends StatefulWidget {
  const CustomContainer({super.key});

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  double alpha = 1;
  @override
  Widget build(BuildContext context) {
    print("Build Method is called ");

    final providerData = Provider.of<SliderProvider>(context, listen: false);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<SliderProvider>(
              builder: (context, value, child) {
                return Text(
                  "adsda",
                  style: TextStyle(fontSize: value.silderValue * 100),
                );
              },
            ),

            Consumer<SliderProvider>(
              builder: (context, value, child) {
                return Container(
                  color: Colors.red.withValues(alpha: value.silderValue),
                  height: 100,
                  width: 100,
                );
              },
            ),

            TextButton(
                onPressed: () {
                  providerData.changeInSliderValue(0.1);
                },
                child: Text("data")),

            Consumer<SliderProvider>(
              builder: (context, value, child) {
                return Slider(
                  min: 0.1,
                  max: 1.0,
                  value: value.silderValue,
                  onChanged: (SilderValue) {
                    value.changeInSliderValue(SilderValue);
                  },
                );
              },
            )

            // Slider(
            //   min: 0.1,
            //   max: 1.0,
            //   value: alpha,
            //   onChanged: (value) {
            //     print(alpha);
            //     alpha = value;
            //     setState(() {});
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
