import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: Scaffold(
            body: Center(
                child: Column(
              children: [
                SizedBox(
                  width: 100.w,
                  height: 100.h,
                )
              ],
            )),
          )),
    );
  }
}

// class SimlePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint();
//     paint.color = Colors.yellow;
//     paint.style = PaintingStyle.fill;
//     canvas.drawCircle(const Offset(30, 50), 150, paint);

//     final eyePaint = Paint();
//     eyePaint.color = Colors.black;
//     eyePaint.style = PaintingStyle.fill;
//     canvas.drawCircle(const Offset(0, 10), 30, eyePaint);

//     canvas.drawCircle(const Offset(90, 10), 30, eyePaint);
//     final simlePainter = Paint();
//     simlePainter.color = Colors.black;
//     simlePainter.style = PaintingStyle.stroke;
//     canvas.drawArc(
//         Rect.fromCenter(center: const Offset(40, 100), width: 200, height: 40),
//         0.2,
//         3,
//         false,
//         simlePainter..strokeWidth = 2);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// // Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 CircleAvatar(
// //                   backgroundColor: Colors.yellow,
// //                   radius: 100,
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     crossAxisAlignment: CrossAxisAlignment.center,
// //                     children: [
// //                       Padding(
// //                         padding: EdgeInsets.only(left: 60, bottom: 40),
// //                         child: Row(
// //                           children: [
// //                             CircleAvatar(
// //                               backgroundColor: Colors.black,
// //                               radius: 15,
// //                             ),
// //                             SizedBox(
// //                               width: 10,
// //                             ),
// //                             CircleAvatar(
// //                               backgroundColor: Colors.black,
// //                               radius: 15,
// //                             ),
// //                           ],
// //                         ),
// //                       )
// //                     ],
// //                   ),
// //                 )
// //               ],
// //             ),
