import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:task/Providers/UserProvider.dart';
import 'package:task/services/drive_upload_service.dart';
import 'package:task/services/id_image_service.dart';
import 'package:task/widgets/AppBar.dart';
import 'package:task/widgets/Button.dart';
import 'package:task/widgets/save_images.dart';

//you should create your own secret key through google cloud platform

class UploadToDrivePage extends StatefulWidget {
  @override
  _UploadToDrivePageState createState() => _UploadToDrivePageState();
}

class _UploadToDrivePageState extends State<UploadToDrivePage> {
  File? _frontImage;
  File? _backImage;
  late String jsonString;

  final String folderId = '0AIINQarwUhEiUk9PVA';

  final IdImageService _idImageService = IdImageService();
  late DriveUploadService _driveUploadService;

  @override
  void initState() {
    super.initState();
    _loadJsonString();
  }

  Future<void> _loadJsonString() async {
    jsonString = await rootBundle.loadString(
      //and replace his with your own secret key file
      //'assets/your-secrect-key-file.json',
      '',
    );

    _driveUploadService = DriveUploadService(
      folderId: folderId,
      serviceAccountJson: jsonString,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Scan and Upload your National ID'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Front ID
            const Text(
              'Please take a photo for Front of ID',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _frontImage != null
                ? Image.file(_frontImage!, height: 200)
                : Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image_outlined, size: 80),
                ),
            const SizedBox(height: 8),

            PrimaryButton(
              width: 270,
              height: 48,
              onPressed: () async {
                File? file = await _idImageService.pickAndCropImage(
                  side: 'front',
                );
                if (file != null) {
                  setState(() => _frontImage = file);

                  final userProvider = context.read<UserProvider>();
                  final fullName =
                      '${userProvider.firstName}_${userProvider.lastName}'
                          .trim();
                  final safeName = fullName.isEmpty ? 'Unknown_User' : fullName;
                  userProvider.setFrontId(
                    file,
                    fileName: '${safeName}_ID_FRONT.jpg',
                  );
                }
              },
              text: 'Capture Front ID',
            ),

            const SizedBox(height: 24),

            // Back ID
            const Text(
              'Please take a photo for Back of ID',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _backImage != null
                ? Image.file(_backImage!, height: 200)
                : Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image_outlined, size: 80),
                ),
            const SizedBox(height: 8),

            PrimaryButton(
              width: 270,
              height: 48,
              onPressed: () async {
                File? file = await _idImageService.pickAndCropImage(
                  side: 'back',
                );
                if (file != null) {
                  setState(() => _backImage = file);

                  final userProvider = context.read<UserProvider>();

                  final fullName =
                      '${userProvider.firstName}_${userProvider.lastName}'
                          .trim();
                  final safeName = fullName.isEmpty ? 'Unknown_User' : fullName;
                  userProvider.setBackId(
                    file,
                    fileName: '${safeName}_ID_BACK.jpg',
                  );
                }
              },
              text: 'Capture Back ID',
            ),

            const SizedBox(height: 60),

            // Upload button
            DriveUploadButton(driveUploadService: _driveUploadService),
          ],
        ),
      ),
    );
  }
}
