
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pizza_app/config/image_path/app_images.dart';
// import 'package:pizza_app/utils/sizebox_extension.dart';

// import '../../services/splash_screen/splash_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   final SplashServices _splashServices = SplashServices();
//   @override
//   void initState() {
//     _splashServices.splashFunction(context);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           70.h.ph,
//           ForkAnimation(),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Image.asset(AppImages.titlePng),
//           )
//         ],
//       ),
//     );
//   }
// }

// class ForkAnimation extends StatefulWidget {
//   const ForkAnimation({super.key});

//   @override
//   State<ForkAnimation> createState() => _ForkAnimationState();
// }

// class _ForkAnimationState extends State<ForkAnimation> {
//   bool _isForkVisible = false;

//   @override
//   void initState() {
//     super.initState();
//     // Delay the animation to make it visible when the widget appears
//     Future.delayed(Duration(milliseconds: 300), () {
//       setState(() {
//         _isForkVisible = true;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 600,
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage(AppImages.onlyD),
//           fit: BoxFit.fitHeight,
//         ),
//       ),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           // Calculate 50% of the container's width and height
//           double forkWidth = constraints.maxWidth * 0.5;
//           double forkHeight = constraints.maxHeight * 0.1;

//           return Stack(
//             children: [
//               AnimatedPositioned(
//                 duration: const Duration(seconds: 1), // Animation duration
//                 curve: Curves.easeInOut, // Smooth curve for the animation
//                 left: _isForkVisible
//                     ? -5
//                     : -forkWidth, // Start off-screen and animate to 0
//                 top: _isForkVisible
//                     ? (constraints.maxHeight - forkHeight) / 4
//                     : (constraints.maxHeight - forkHeight) /
//                         1, // Center vertically
//                 child: SizedBox(
//                   height: 350.h,
//                   width: 270.w,
//                   child: Image.asset(
//                     AppImages.forkWhite,
//                     width:
//                         forkWidth, // Set width to 50% of the container's width
//                     height:
//                         forkHeight, // Set height to 50% of the container's height
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
