import 'package:flutter/material.dart';

class ListViewExample extends StatelessWidget {
  ListViewExample({super.key});

  List<String> data = ['afaq', "jamal", "awais", "shayan", "hasham", "calss"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ListV"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: data.length,
            //     itemBuilder: (context, index) {
            //       print(index);
            //       return Card(
            //         color: Colors.amber,
            //         child: ListTile(
            //           leading: const CircleAvatar(),
            //           title: Text(data[5]),
            //           trailing: const Icon(Icons.add),
            //         ),
            //       );
            //     },
            //   ),
            // )
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  print(index);
                  return Container(
                    width: double.infinity,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red),
                  );
                },
              ),
            )
//
          ],
        ),
      ),
    );
  }
}

// Listview.builder example

//  Expanded(
//               child: ListView.builder(
//                 itemCount: data.length,
//                 itemBuilder: (context, index) {
//                   print(index);
//                   return Card(
//                     color: Colors.amber,
//                     child: ListTile(
//                       leading: const CircleAvatar(),
//                       title: Text(data[5]),
//                       trailing: const Icon(Icons.add),
//                     ),
//                   );
//                 },
//               ),
//             )
//

// Gridview ,builder
// /// Expanded(
//                 child: GridView.builder(
//               itemCount: data.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3, crossAxisSpacing: 40, mainAxisSpacing: 40),
//               itemBuilder: (context, index) {
//                 return Card(color: Colors.amber, child: Text(data[index]));
//               },
//             )),
// GrdiView Example

//  Expanded(
//                 child: GridView(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3, crossAxisSpacing: 40, mainAxisSpacing: 40),
//               children: [
//                 Card(
//                   color: Colors.amber,
//                   child: ListTile(
//                     leading: const CircleAvatar(),
//                     title: Text(data[5]),
//                     trailing: const Icon(Icons.add),
//                   ),
//                 ),
//                 Card(
//                   color: Colors.amber,
//                   child: ListTile(
//                     leading: const CircleAvatar(),
//                     title: Text(data[5]),
//                     trailing: const Icon(Icons.add),
//                   ),
//                 ),
//                 Card(
//                   color: Colors.amber,
//                   child: ListTile(
//                     leading: const CircleAvatar(),
//                     title: Text(data[5]),
//                     trailing: const Icon(Icons.add),
//                   ),
//                 ),
//                 Card(
//                   color: Colors.amber,
//                   child: ListTile(
//                     leading: const CircleAvatar(),
//                     title: Text(data[5]),
//                     trailing: const Icon(Icons.add),
//                   ),
//                 )
//               ],
//             ))

// Container(
//             padding: const EdgeInsets.only(left: 10),
//             width: double.infinity,
//             height: 45,
//             decoration: const BoxDecoration(color: Colors.black12),
//             child: Row(
//               children: [
//                 Container(
//                   width: 50,
//                   height: 50,
//                   decoration: const BoxDecoration(
//                       color: Colors.black, shape: BoxShape.circle),
//                 ),
//                 const CircleAvatar(backgroundColor: Colors.black),
//                 const Text(
//                   "Foo01",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             width: double.infinity,
//             height: 5,
//             color: Colors.green,
//           ),
//           const Divider(
//             endIndent: 0.1,
//             indent: 0.2,
//             color: Colors.red,
//           ),
//           Container(
//             padding: const EdgeInsets.only(left: 10),
//             width: double.infinity,
//             height: 45,
//             decoration: const BoxDecoration(color: Colors.black12),
//             child: Row(
//               children: [
//                 Container(
//                   width: 50,
//                   height: 50,
//                   decoration: const BoxDecoration(
//                       color: Colors.black, shape: BoxShape.circle),
//                 ),
//                 const CircleAvatar(backgroundColor: Colors.black),
//                 const Text(
//                   "Foo01",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),

//  const Card(
//               color: Colors.amber,
//               child: ListTile(
//                 leading: CircleAvatar(),
//                 title: Text("data"),
//                 trailing: Icon(Icons.add),
//               ),
//             ),
//             const Card(
//               color: Colors.amber,
//               child: ListTile(
//                 leading: CircleAvatar(),
//                 title: Text("data"),
//                 trailing: Icon(Icons.add),
//               ),
//             ),
//             const Card(
//               color: Colors.amber,
//               child: ListTile(
//                 leading: CircleAvatar(),
//                 title: Text("data"),
//                 trailing: Icon(Icons.add),
//               ),
//             ),
//             const Card(
//               color: Colors.amber,
//               child: ListTile(
//                 leading: CircleAvatar(),
//                 title: Text("data"),
//                 trailing: Icon(Icons.add),
//               ),
//             ),
