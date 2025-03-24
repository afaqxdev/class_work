// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'home_view_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    print(Get.height);
    final counterController = Get.put(CounterContoller());
    print("rebuild");
    return Scaffold(
      drawer: Drawer(
        child: DrawerHeader(
            child: Column(
          children: [
            CircleAvatar(
              radius: 100,
              child: Icon(
                Icons.person,
                size: 200,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: 200,
              height: 50,
              color: Colors.amber,
              child: Center(child: Text("Home Screen")),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 200,
              height: 50,
              color: Colors.red,
              child: Center(child: Text("Home Screen")),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 200,
              height: 50,
              color: Colors.orange,
              child: Center(child: Text("Home Screen")),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 200,
              height: 50,
              color: Colors.black,
              child: Center(
                  child: Text(
                "Login Screen",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ],
        )),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: TextStyle(fontSize: Get.height * 0.06),
            ),
            // GetBuilder<CounterContoller>(
            //   builder: (data) {
            //     print("object");
            //     return Text(
            //       data.counter.toString(),
            //       style: Theme.of(context).textTheme.headlineMedium,
            //     );
            //   },
            // ),
            image == null
                ? Text("Image is null")
                : CircleAvatar(
                    radius: 100, child: Image.file(File(image!.path))),
            Obx(
              () {
                return Text(counterController.counter2.value.toString());
              },
            ),

            // image != null
            //     ? SizedBox(height: 100, child: Image.file(File(image!.path)))
            //     : Text("No Image for the moment "),
            IconButton(
                onPressed: () async {
                  image = await _picker.pickImage(source: ImageSource.camera);

                  print(image!.path);
                  setState(() {});
                },
                icon: Icon(Icons.camera))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterController.increment2;
          // Get.snackbar("State Update", "Successfully",
          //     backgroundColor: Colors.red);   pop up

          // Get.to(MainScreen()); navigation purpose

          // ALter dialogue
          // Get.defaultDialog(

          //     title: "Are you sure yiu want to exist",
          //     cancel: TextButton(
          //         onPressed: () {
          //           Get.back();
          //         },
          //         child: Text("Decline")),
          //     confirm: TextButton(onPressed: () {}, child: Text("Confirm")));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
