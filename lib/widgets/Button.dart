import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // Nullable to allow disabling
  final bool isLoading; // New optimization for API calls
  final double width;
  final double height;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width = double.infinity, // Set to infinity to fill parent width
    this.height = 54, // Increased height to match Figma
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Padding to match the side margins in your design
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed, // Disable if loading
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2F80ED),
            disabledBackgroundColor: const Color(0xFF2F80ED).withOpacity(0.6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 5, // Design looks flat/modern
          ),
          child:
              isLoading
                  ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                  : Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18, // Slightly larger
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
        ),
      ),
    );
  }
}
