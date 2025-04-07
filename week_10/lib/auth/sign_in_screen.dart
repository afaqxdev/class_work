import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:week_10/auth/forgot_password_screen.dart';
import 'package:week_10/auth/sign_up_screen.dart';
import 'package:week_10/home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, // Center the column contents vertically
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo (Optional, can add image or logo widget here)

              SizedBox(height: 40),

              // Email TextField
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),

              // Password TextField
              TextField(
                controller: passController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                obscureText: true,
              ),
              SizedBox(height: 10),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ForgotPasswordScreen();
                      },
                    ));
                  },
                  child: Text('Forgot Password?'),
                ),
              ),

              SizedBox(height: 10),

              // Login Button
              MaterialButton(
                color: Colors.blue, // Set button color
                textColor: Colors.white, // Set text color
                padding: EdgeInsets.symmetric(vertical: 16), // Set padding
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12), // Set rounded corners
                ),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passController.text.trim(),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Successfully Logged In"),
                        backgroundColor: Colors.green,
                      ),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  } on FirebaseAuthException catch (e) {
                    print("FirebaseAuthException Code: ${e.code}");

                    String errorMessage;

                    if (e.code == 'user-not-found') {
                      errorMessage = 'No user found for that email.';
                    } else if (e.code == 'wrong-password') {
                      errorMessage = 'Wrong password provided.';
                    } else if (e.code == 'invalid-email') {
                      errorMessage = 'The email address is badly formatted.';
                    } else if (e.code == 'user-disabled') {
                      errorMessage = 'This user has been disabled.';
                    } else if (e.code == 'too-many-requests') {
                      errorMessage = 'Too many requests. Try again later.';
                    } else {
                      errorMessage = 'Firebase error: ${e.message}';
                    }
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMessage),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } catch (e) {
                    print("General Error: $e");

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Something went wrong.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },

                child: Text('Login', style: TextStyle(fontSize: 16)),
              ),

              SizedBox(height: 20),
// dont have account section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen();
                        },
                      ));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
