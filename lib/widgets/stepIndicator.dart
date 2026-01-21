import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;

  const StepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final step = index + 1;

        // Logic improvements:
        // 1. isCompleted: Steps already passed
        // 2. isActive: The current step the user is on
        final isCompleted = step < currentStep;
        final isActive = step == currentStep;
        final isHighlighted = isCompleted || isActive;

        return Row(
          children: [
            /// Step Circle
            Container(
              width: 32, // Slightly larger to match the Figma feel
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // Background is blue if active or completed
                color: isHighlighted ? const Color(0xFF2F80ED) : Colors.white,
                border: Border.all(
                  color:
                      isHighlighted
                          ? const Color(0xFF2F80ED)
                          : Colors.grey.shade300,
                  width: 1.5,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "$step",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  // Text is white if the circle is blue
                  color: isHighlighted ? Colors.white : Colors.grey.shade400,
                ),
              ),
            ),

            /// Connector Line
            if (step != 3)
              Container(
                width: 80, // Adjusted for better centering on small screens
                height: 2,
                // The line is blue if the NEXT step is completed or active
                color:
                    (step < currentStep)
                        ? const Color(0xFF2F80ED)
                        : Colors.grey.shade300,
              ),
          ],
        );
      }),
    );
  }
}
