import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/Pages/Registrated.dart';
import 'package:task/Providers/UserProvider.dart';
import 'package:task/services/user_submitted.dart';
import 'package:task/widgets/AppBar.dart';
import 'package:task/widgets/DataBox.dart';
import 'package:task/widgets/submitted_id_box.dart';
import 'package:task/widgets/SectionLabel.dart';
import 'package:task/widgets/stepIndicator.dart';
import 'package:task/widgets/Button.dart';

class AccountSummaryPage extends StatelessWidget {
  const AccountSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "Create Account"),
      body: SafeArea(
        child: SingleChildScrollView(
          // Added scroll view to prevent overflow
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(child: StepIndicator(currentStep: 3)),
              const SizedBox(height: 20),

              // Full Name
              const SectionLabel(icon: Icons.person, label: "FULL NAME"),
              DataBox(text: "${user.firstName} ${user.lastName}"),

              // Phone Numbers
              const SectionLabel(icon: Icons.phone, label: "PHONE NUMBERS"),
              DataBox(text: user.mobileNumber.toString()),
              const SizedBox(height: 8),
              DataBox(text: user.landlineNumber.toString()),

              // Email
              const SectionLabel(
                icon: Icons.alternate_email,
                label: "EMAIL ADDRESS",
              ),
              DataBox(text: user.email),
              // Home Address
              const SectionLabel(
                icon: Icons.location_on,
                label: "HOME ADDRESS",
              ),
              DataBox(
                text:
                    "${user.street} Street, ${user.selectedArea}, ${user.selectedCity}\n Building ${user.building} Floor ${user.floor} Apartment ${user.apartment} ",
              ),

              // National ID
              const SectionLabel(
                icon: Icons.badge_outlined,
                label: "NATIONAL ID",
              ),

              IdUploadBox(label: 'Front ID', image: user.idFrontImage),
              const SizedBox(height: 8),

              IdUploadBox(label: 'Back ID', image: user.idBackImage),

              
              const SizedBox(height: 30),

              // Centered Submit Button
              Center(
                child: PrimaryButton(
                  width: 270,
                  height: 48,
                  text: "Submit",
                  onPressed: () async {
                    final userProvider = context.read<UserProvider>();

                    final success = await UserSubmissionService.submit(
                      context,
                      userProvider,
                    );

                    if (success) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => const RegistrationCompletePage(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
