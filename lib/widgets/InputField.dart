import 'package:flutter/material.dart';

class OutlinedInput extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  // final Widget? suffixIcon;
  final double? width;
  final TextEditingController? controller;
  final String? Function(String?)? validator; // Added validator for error logic

  const OutlinedInput({
    super.key,
    required this.label,
    this.keyboardType = TextInputType.text,
    // this.suffixIcon,
    this.width,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              // suffixIcon: suffixIcon,
              labelText: label,
              labelStyle: const TextStyle(color: Colors.black54, fontSize: 14),
              floatingLabelStyle: const TextStyle(color: Colors.black),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              // Default Border
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              // Normal state
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              // Focused state
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
              ),
              // --- ERROR STYLING ---
              errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
