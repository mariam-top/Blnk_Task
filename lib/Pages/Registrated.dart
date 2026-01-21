import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/Pages/Step1.dart';
import 'package:task/Providers/UserProvider.dart';
import 'package:task/widgets/Button.dart'; // Using your existing PrimaryButton

class RegistrationCompletePage extends StatelessWidget {
  const RegistrationCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Spacer(flex: 2),
              const SizedBox(height: 60),

              // 1. Success Icon (Green Circle)
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Color(0xFF43B581), // Green color from image
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 80),
              ),
              const SizedBox(height: 40),

              // 2. Title
              const Text(
                "Registration Complete",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              const SizedBox(height: 20),

              // 3. Description text
              const Text(
                "Congratulations! You have successfully completed the registration process. Your profile is now set up, and now you can start exploring all features and benefits we offer",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 91, 91, 91),
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 300),

              // 4. Register Another User Button
              PrimaryButton(
                width: 270,
                height: 48,
                text: "Register Another User",
                onPressed: () async {
                  final userProvider = context.read<UserProvider>();
                  // Navigate back to the first screen and clear history
                  // Navigator.of(context).popUntil((route) => route.isFirst);

                  userProvider.resetUserData();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateAccountStep1(),
                    ),
                    (route) => false, // This removes all previous routes
                  );
                  // Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
