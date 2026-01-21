import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task/Pages/Step1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CreateAccountStep1()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background with diagonal gradient
          Image.asset(
            "assets/Images/Logo-background.png",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover, // This ensures it covers the full screen
          ),

          // 2. Centered Logo Image (Replacing the old text and icon)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 90,
              ), // Increase this number to move it higher
              child: Image.asset(
                "assets/Images/Logo.png",
                width: 300,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // 3. Footer Copyright Text
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 150),
              child: Text(
                "Company Name © 2024",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
