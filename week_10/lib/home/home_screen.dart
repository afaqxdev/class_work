// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:week_10/auth/sign_in_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            FirebaseAuth.instance.signOut();

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Successfully Logout"),
              backgroundColor: Colors.green,
            ));
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return LoginScreen();
              },
            ));
          },
          icon: Icon(Icons.logout),
          label: Text("Logout"),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
