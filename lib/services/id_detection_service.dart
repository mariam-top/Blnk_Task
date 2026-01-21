import 'dart:io';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:image/image.dart' as img;

// detects and crops ID for picked image file

class IdDetectionService {
  Future<File> detectAndCropID(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);

    final objectDetector = ObjectDetector(
      options: ObjectDetectorOptions(
        mode: DetectionMode.single,
        classifyObjects: false,
        multipleObjects: false,
      ),
    );

    final objects = await objectDetector.processImage(inputImage);
    await objectDetector.close();

    // If nothing detected → return original
    if (objects.isEmpty) return imageFile;

    final box = objects.first.boundingBox;
    final originalImage = img.decodeImage(imageFile.readAsBytesSync());

    if (originalImage == null) return imageFile;

  //clamps image within bounds
    final x = box.left.clamp(0, originalImage.width - 1).toInt();
    final y = box.top.clamp(0, originalImage.height - 1).toInt();
    final w = box.width.clamp(1, originalImage.width - x).toInt();
    final h = box.height.clamp(1, originalImage.height - y).toInt();

    final cropped = img.copyCrop(
      originalImage,
      x: x,
      y: y,
      width: w,
      height: h,
    );

    final croppedFile = File(
      imageFile.path.replaceFirst('.jpg', '_cropped.jpg'),
    );

    await croppedFile.writeAsBytes(img.encodeJpg(cropped));

    return croppedFile;
  }
}
