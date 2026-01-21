import 'dart:io';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';

//upload back and front image to google drive 

class DriveUploadService {
  final String folderId;
  final String serviceAccountJson;

  DriveUploadService({
    required this.folderId,
    required this.serviceAccountJson,
  });

  /// Upload a single image to Google Drive
  Future<void> uploadSingle({
    required File file,
    required String fileName,
  }) async {
    final credentials = ServiceAccountCredentials.fromJson(serviceAccountJson);

    final authClient = await clientViaServiceAccount(credentials, [
      drive.DriveApi.driveScope,
    ]);

    final driveApi = drive.DriveApi(authClient);

    final driveFile =
        drive.File()
          ..name = fileName
          ..parents = [folderId];

    await driveApi.files.create(
      driveFile,
      uploadMedia: drive.Media(file.openRead(), await file.length()),
      supportsAllDrives: true,
    );

    authClient.close();
  }

  /// Upload front + back ID
  Future<void> uploadBoth({
    required File frontImage,
    required File backImage,
    required String frontFileName,
    required String backFileName,
  }) async {
    await uploadSingle(file: frontImage, fileName: frontFileName);

    await uploadSingle(file: backImage, fileName: backFileName);
  }
}
