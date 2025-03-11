import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:week_6/website_model.dart';

class ExampleGet extends StatefulWidget {
  const ExampleGet({super.key});

  @override
  State<ExampleGet> createState() => _ExampleGetState();
}

class _ExampleGetState extends State<ExampleGet> {
  List<FromWebSiteMidel> apiData = [];
  Future<void> getDatafromAPi() async {
    String link = 'https://fakestoreapi.com/products/';

    final response = await http.get(Uri.parse(link));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for (var i in data) {
        apiData.add(FromWebSiteMidel.fromJson(i));
      }
      setState(() {});

      Fluttertoast.showToast(
          msg: 'Succesfully Hit ${response.statusCode}',
          toastLength: Toast.LENGTH_LONG);
    } else {
      Fluttertoast.showToast(msg: 'error ${response.statusCode}');
    }
  }

  @override
  void initState() {
    getDatafromAPi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Get'),
      ),
      body: ListView.builder(
          itemCount: apiData.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: double.infinity,
              height: 200,
              child: Column(
                children: [
                  Text(apiData[index].id.toString()),
                  Text(apiData[index].description.toString()),
                  Text(apiData[index].price.toString()),
                  Image.network(
                    apiData[index].image.toString(),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
