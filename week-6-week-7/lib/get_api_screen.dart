// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:week_6/get_api_model.dart';

// class GetApiScreen extends StatefulWidget {
//   const GetApiScreen({super.key});

//   @override
//   State<GetApiScreen> createState() => _GetApiScreenState();
// }

// class _GetApiScreenState extends State<GetApiScreen> {
//   List<GetModel> localData = [];

//   Future<void> getApi() async {
//     localData.clear();
//     try {
//       final response =
//           await http.get(Uri.parse('https://fakestoreapi.com/products/'));

//       print(response.statusCode);

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         for (var i = 0; i < data.length; i++) {
//           localData.add(GetModel.fromJson(data[i]));
//         }

//         setState(() {});
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Error ${response.statusCode}')));
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Error $e')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text('Get Api Screen'),
//       ),
//       body: Column(
//         children: [
//           TextButton(
//               onPressed: () {
//                 getApi();
//               },
//               child: const Text("data")),
//           const Center(
//             child: Text('Get Api Screen'),
//           ),
//           Expanded(
//               child: ListView.builder(
//             itemCount: localData.length,
//             itemBuilder: (context, index) {
//               return Card(
//                 elevation: 1,
//                 child: ListTile(
//                   leading: Image.network(localData[index].image),
//                   title: Text(localData[index].name),
//                   subtitle: Text(localData[index].description),
//                   trailing: Text(localData[index].price),
//                 ),
//               );
//             },
//           ))
//         ],
//       ),
//     );
//   }
// }
