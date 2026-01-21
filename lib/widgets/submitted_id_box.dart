import 'dart:io';
import 'package:flutter/material.dart';
import 'package:task/Pages/IdPreview.dart';

class IdUploadBox extends StatelessWidget {
  final String label;
  final File? image;

  const IdUploadBox({Key? key, required this.label, required this.image})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          image == null
              ? null
              : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => IdImagePreviewPage(title: label, image: image!),
                  ),
                );
              },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F0F9),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            const Icon(Icons.image_outlined, color: Color(0xFF4A4A4A)),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: image != null ? Colors.blue : Colors.grey,
                decoration: image != null ? TextDecoration.underline : null,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
