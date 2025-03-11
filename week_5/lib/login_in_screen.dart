import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:week_5/colors.dart';
import 'package:week_5/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome",
                    style:
                        TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Back",
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600,
                        color: blue),
                  ),
                ],
              ),
              Text(
                "We missed you! Login to continue your journey with us.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 100,
              ),
              TextField(
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
              const SizedBox(
                height: 10,
              ),
              TextField(
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const HomeScreen();
                    },
                  ));
                },
                child: Container(
                  width: 320.w,
                  height: 45.h,
                  margin: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: blue, borderRadius: BorderRadius.circular(12.r)),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
