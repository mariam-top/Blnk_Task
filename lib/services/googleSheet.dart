import 'package:flutter/services.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart';

//you should create your own secret key through google cloud platform

class GoogleSheetsService {
  final String spreadsheetId;
  sheets.SheetsApi? _api;

  GoogleSheetsService(this.spreadsheetId);

  Future<void> init() async {
    final json = await rootBundle.loadString(
      //and replace his with your own secret key file
      //'assets/your-secrect-key-file.json',
      '',
    );
    final credentials = ServiceAccountCredentials.fromJson(json);

    final client = await clientViaServiceAccount(credentials, [
      sheets.SheetsApi.spreadsheetsScope,
    ]);

    _api = sheets.SheetsApi(client);
  }

  Future<void> addUser(List<dynamic> rowData) async {
    final valueRange = sheets.ValueRange(values: [rowData]);

    await _api!.spreadsheets.values.append(
      valueRange,
      spreadsheetId,
      'Sheet1!A1',
      valueInputOption: 'RAW',
    );
  }
}
