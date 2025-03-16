import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8/counter_provider2.dart';

class CounterExample extends StatefulWidget {
  const CounterExample({super.key});

  @override
  State<CounterExample> createState() => _CounterExampleState();
}

class _CounterExampleState extends State<CounterExample> {
  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<CounterProvider2>(context, listen: false);
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          providerData.incrementCounter();
        },
        child: Container(
          width: 50,
          color: Colors.brown,
          height: 50,
          child: Icon(Icons.add),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Selector<CounterProvider2, double>(
              builder: (context, value, child) {
                print("Selector IS called ");
                return Text(
                  "Data",
                  style: TextStyle(fontSize: value),
                );
              },
              selector: (context, data) {
                return data.fontSize;
              },
            ),
            Consumer<CounterProvider2>(
              builder: (context, value, child) {
                print("Counter Consumer Build");
                return Text("Counter ${value.counterNo.toString()}");
              },
            ),
            InkWell(
              onTap: () {
                providerData.increaseFontSize(30.0);
              },
              child: Container(
                width: 200,
                height: 55,
                color: Colors.red,
                child: Center(
                  child: Text("Button"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
