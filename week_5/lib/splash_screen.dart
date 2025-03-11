import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:week_5/colors.dart';
import 'package:week_5/home_screen.dart';
import 'package:week_5/login_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool islogin = false;
  @override
  void initState() {
    print("init run ");
    Future.delayed(const Duration(seconds: 3), () {
      if (islogin) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        ));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build  run ");

    return Scaffold(
      backgroundColor: blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 63.w,
              height: 51.h,
            ),
            const SizedBox(
              height: 10,
            ),
            Text("WanderStay",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 45.sp,
                    fontFamily: 'Nunito',
                    color: const Color(0xffFFFFFF))),
            Text("Find Your Stay, Your Way",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    fontFamily: 'Nunito',
                    color: const Color(0xffFFD700)))
          ],
        ),
      ),
    );
  }
}
