import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String link = 'https://reqres.in/api/register';

  Future<void> loginUser(String email, String password) async {
    final response = await http
        .post(Uri.parse(link), body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (context) => const GetApiScreen()));
      print(data);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Error, please try again ${response.statusCode.toString()} ')));
      print("object");
      print(response.statusCode);
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  labelText: 'email',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelText: 'password',
                  ))
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(emailController.text);
          loginUser(emailController.text, passwordController.text);
          setState(() {});
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
