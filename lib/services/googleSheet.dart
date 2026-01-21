import 'package:flutter/services.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart';

class GoogleSheetsService {
  final String spreadsheetId;
  sheets.SheetsApi? _api;

  GoogleSheetsService(this.spreadsheetId);

  Future<void> init() async {
    final json = await rootBundle.loadString(
      'assets/task-484821-7e3b2c5fab3e.json',
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
