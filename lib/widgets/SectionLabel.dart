import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  final IconData icon;
  final String label;

  const SectionLabel({Key? key, required this.icon, required this.label})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF4A4A4A)),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Color(0xFF666666),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
