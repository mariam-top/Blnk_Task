import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/Providers/UserProvider.dart';
import 'package:task/services/drive_upload_service.dart';
import 'package:task/Pages/Step3.dart';

class DriveUploadButton extends StatefulWidget {
  final DriveUploadService driveUploadService;

  const DriveUploadButton({super.key, required this.driveUploadService});

  @override
  State<DriveUploadButton> createState() => _DriveUploadButtonState();
}

class _DriveUploadButtonState extends State<DriveUploadButton> {
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _isUploading ? null : _handleUpload,
      child:
          _isUploading
              ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2.5),
              )
              : const Text(
                'Save both images and continue -->',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
    );
  }

  Future<void> _handleUpload() async {
    final user = context.read<UserProvider>();

    if (user.idFrontImage == null || user.idBackImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please capture both images')),
      );
      return;
    }

    setState(() => _isUploading = true);

    try {
      await widget.driveUploadService.uploadBoth(
        frontImage: user.idFrontImage!,
        backImage: user.idBackImage!,
        frontFileName: user.frontIdImageName!,
        backFileName: user.backIdImageName!,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Images uploaded successfully'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AccountSummaryPage()),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Upload failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }
}
