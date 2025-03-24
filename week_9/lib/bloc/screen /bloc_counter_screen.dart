import 'package:flutter/material.dart';
import 'package:week_9/bloc/logic/bloc_state.dart';

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("object");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var var1 = CounterState(1);
          var var2 = CounterState(12);
          print("this var1 ${var1.hashCode}");
          print("this is var2 ${var2.hashCode}");

          print("this is  ${var2 == var1}");

          // context.read<CounterBloc>().add(Increment());
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.abc_outlined),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // BlocListener<CounterBloc, CounterState>(
            //   listener: (context, state) {
            //     if (state.counter > 46) {
            //       ScaffoldMessenger.of(context)
            //           .showSnackBar(SnackBar(content: Text("Im lisnter")));
            //     }
            //   },
            // ),
            // BlocBuilder<CounterBloc, CounterState>(
            //   builder: (context, state) {
            //     return Text(state.counter.toString());
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
