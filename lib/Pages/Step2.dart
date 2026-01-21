import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/Pages/ScanID.dart';
import 'package:task/Providers/UserProvider.dart';
import 'package:task/widgets/AppBar.dart';
import 'package:task/widgets/Button.dart';
import 'package:task/widgets/DropDownInputField.dart';
import 'package:task/widgets/InputField.dart';
import 'package:task/widgets/stepIndicator.dart';

class CreateAccountStep2 extends StatefulWidget {
  const CreateAccountStep2({super.key});

  @override
  State<CreateAccountStep2> createState() => _CreateAccountStep2State();
}

class _CreateAccountStep2State extends State<CreateAccountStep2> {
  // 1. Create the Form Key
  final _formKey = GlobalKey<FormState>();

  String? selectedArea;
  String? selectedCity;

  final List<String> areas = [
    "Maadi",
    "Nasr City",
    "Zamalek",
    "Dokki",
    "New Cairo",
    "Heliopolis",
    "6th of October",
    "Shubra",
    "Agouza",
    "Mohandessin",
  ];
  final List<String> cities = [
    "Cairo",
    "Giza",
    "Alexandria",
    "Mansoura",
    "Aswan",
    "Luxor",
    "Suez",
    "Ismailia",
    "Tanta",
    "Fayoum",
  ];

  final apartmentController = TextEditingController();
  final floorController = TextEditingController();
  final buildingController = TextEditingController();
  final streetController = TextEditingController();
  final landmarkController = TextEditingController();

  @override
  void dispose() {
    apartmentController.dispose();
    floorController.dispose();
    buildingController.dispose();
    streetController.dispose();
    landmarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Create Account"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          // 2. Wrap with Form and set autovalidateMode
          child: Form(
            key: _formKey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const StepIndicator(currentStep: 2),
                const SizedBox(height: 32),

                /// Row for Appartment, Floor, Building
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: OutlinedInput(
                        label: "Appartment",
                        controller: apartmentController,
                        keyboardType:
                            TextInputType.number, // Opens numeric keypad
                        validator: (v) {
                          if (v == null || v.isEmpty) return "Required";
                          if (int.tryParse(v) == null)
                            return "Numbers only"; // Numeric check
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedInput(
                        label: "Floor",
                        controller: floorController,
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v == null || v.isEmpty) return "Required";
                          if (int.tryParse(v) == null) return "Numbers only";
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedInput(
                        label: "Building",
                        controller: buildingController,
                        // keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v == null || v.isEmpty) return "Required";
                          // if (int.tryParse(v) == null) return "Numbers only";
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                OutlinedInput(
                  label: "Street Name",
                  controller: streetController,
                  validator:
                      (v) => v!.isEmpty ? "Street name is required" : null,
                ),
                const SizedBox(height: 20),

                /// Row for Area and City (Dropdowns)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        label: "Area",
                        // controller: areaController,
                        items: areas,
                        value: selectedArea,
                        // Validator for dropdown
                        onChanged: (val) => setState(() => selectedArea = val),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomDropdown(
                        label: "City",
                        items: cities,
                        value: selectedCity,
                        onChanged: (val) => setState(() => selectedCity = val),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                OutlinedInput(
                  label: "Land Mark",
                  controller: landmarkController,
                  // Validator is optional for landmarks
                ),

                const SizedBox(
                  height: 250,
                ), // Adjusted height for better layout

                PrimaryButton(
                  width: 270,
                  height: 48,
                  text: "Next",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final userProvider = context.read<UserProvider>();

                      // Save Step 2 data to provider
                      userProvider.updateBasicInfo(
                        firstName: userProvider.firstName,
                        lastName: userProvider.lastName,
                        email: userProvider.email,
                        mobileNumber: userProvider.mobileNumber,
                        landlineNumber: userProvider.landlineNumber,
                        apartment: int.tryParse(apartmentController.text) ?? 0,
                        floor: int.tryParse(floorController.text) ?? 0,
                        building: buildingController.text,
                        street: streetController.text,
                        landmark: landmarkController.text,
                      );

                      // Save city/area to provider
                      if (selectedCity != null && selectedArea != null) {
                        userProvider.updateCityArea(
                          city: selectedCity!,
                          area: selectedArea!,
                        );
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UploadToDrivePage(),
                        ),
                      );
                    }
                  },
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
