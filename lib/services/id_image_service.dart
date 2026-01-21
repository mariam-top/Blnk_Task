import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:task/services/id_detection_service.dart';

//pick Image function 

class IdImageService {
  final ImagePicker _picker = ImagePicker();
  final IdDetectionService _idDetectionService = IdDetectionService();

  Future<File?> pickAndCropImage({
    required String side, // "front" or "back"
  }) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 90,
    );

    if (pickedFile == null) return null;

    final originalImage = File(pickedFile.path);

    final croppedImage = await _idDetectionService.detectAndCropID(
      originalImage,
    );

    // Rename file with side info
    final newPath = pickedFile.path.replaceFirst('.jpg', '_$side.jpg');

    final finalFile = File(newPath);
    await finalFile.writeAsBytes(await croppedImage.readAsBytes());

    return finalFile;
  }
}
