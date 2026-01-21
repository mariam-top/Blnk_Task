import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/Pages/Step2.dart';
import 'package:task/Providers/UserProvider.dart';
import 'package:task/widgets/Button.dart';
import 'package:task/widgets/InputField.dart';
import 'package:task/widgets/stepIndicator.dart';

class CreateAccountStep1 extends StatefulWidget {
  const CreateAccountStep1({super.key});

  @override
  State<CreateAccountStep1> createState() => _CreateAccountStep1State();
}

class _CreateAccountStep1State extends State<CreateAccountStep1> {
  // 1. Create a GlobalKey to manage the Form state
  final _formKey = GlobalKey<FormState>();

  // ✅ TextEditingControllers for Step 1 fields
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final landlineController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    landlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Create Account",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          // 2. Wrap the entire column in a Form widget
          child: Form(
            key: _formKey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const StepIndicator(currentStep: 1),
                const SizedBox(height: 20),
                const Text(
                  "Welcome! Let's get started by gathering some basic "
                  "information about you. Please fill out the following fields",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 100, 100, 100),
                  ),
                ),
                const SizedBox(height: 32),

                // 3. Add Validators to each field
                OutlinedInput(
                  label: "First Name",
                  controller: firstNameController,
                  validator:
                      (value) =>
                          value!.isEmpty
                              ? "Please enter your first name"
                              : null,
                ),
                const SizedBox(height: 20),

                OutlinedInput(
                  label: "Last Name",
                  controller: lastNameController,
                  validator:
                      (value) =>
                          value!.isEmpty ? "Please enter your last name" : null,
                ),
                const SizedBox(height: 20),

                OutlinedInput(
                  label: "Mobile Number",
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Phone number is required";
                    if (value.length < 11)
                      return "Enter a valid 11-digit number";
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                OutlinedInput(
                  label: "Landline",
                  controller: landlineController,
                  keyboardType: TextInputType.phone,
                  // Optional field: no validator needed, or simple length check
                ),
                const SizedBox(height: 20),

                OutlinedInput(
                  label: "Email",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Email is required";
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 120),

                PrimaryButton(
                  width: 270,
                  height: 48,
                  text: "Next",
                  isLoading: false,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final userProvider = context.read<UserProvider>();

                      // Save Step 1 data to provider
                      userProvider.updateBasicInfo(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        email: emailController.text,
                        mobileNumber: int.tryParse(mobileController.text) ?? 0,
                        landlineNumber:
                            int.tryParse(landlineController.text) ?? 0,
                        apartment: 0, // Step 2 will update
                        floor: 0,
                        building: '',
                        street: '',
                        landmark: '',
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateAccountStep2(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
