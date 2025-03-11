// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_screen/mobile_screen.dart';

void main() {
  runApp(const ScreenUtilInit(
    child: MaterialApp(
      home: HomeScreenMobile(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}






 //Text widget
// Text(
//       "data",
//       style: TextStyle(
//           fontSize: 30, fontWeight: FontWeight.w500, color: Colors.amberAccent),
//     ),



//Sizebox

  // SizedBox(
  //         width: 20,
  //         height: 30,
  //       ),





  // custombutton

  // InkWell(
  //                 onTap: () {},
  //                 child: const Text("orgot Password"),
  //               )



//  const Row(
//                   children: [
//                     Text(
//                       "data",
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                       child: Text(
//                           "afsasfsajfkjsdhfksdhfkhfkjsdhfkjashfaskfhaskdhkasjhdkajshdkasj"),
//                     )
//                   ],
//                 ),

    //  Stack(
    //               children: [
    //                 Container(
    //                   width: 110,
    //                   height: 100,
    //                   color: Colors.red,
    //                 ),
    //                 Container(
    //                   width: 30,
    //                   height: 49,
    //                   color: Colors.green,
    //                 ),
    //                 Positioned(
    //                   bottom: 10,
    //                   right: 0,
    //                   top: 80,
    //                   child: Container(
    //                     width: 10,
    //                     height: 20,
    //                     color: Colors.black,
    //                   ),
    //                 ),
    //               ],
    //             ),