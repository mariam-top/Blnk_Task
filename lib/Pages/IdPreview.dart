import 'dart:io';

import 'package:flutter/material.dart';

class IdImagePreviewPage extends StatelessWidget {
  final String title;
  final File image;

  const IdImagePreviewPage({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      backgroundColor: Colors.black,
      body: Center(child: InteractiveViewer(child: Image.file(image))),
    );
  }
}
