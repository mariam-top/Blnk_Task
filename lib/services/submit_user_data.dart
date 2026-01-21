import 'package:flutter/material.dart';
import 'package:task/Providers/UserProvider.dart';
import 'package:task/services/googleSheet.dart';
import 'package:provider/provider.dart';

Future<void> submitUserData(BuildContext context) async {
  final user = Provider.of<UserProvider>(context, listen: false);

  final sheetsService = GoogleSheetsService(
    '16xguD8rkDZzg3hDKNhwVggy-bhNsWzTEgmncVuJ_Kdk',
  );
  await sheetsService.init();

  await sheetsService.addUser([
    user.firstName,
    user.lastName,
    user.email,
    user.mobileNumber,
    user.landlineNumber,
    user.apartment,
    user.floor,
    user.building,
    user.street,
    user.landmark,
    user.selectedCity ?? '',
    user.selectedArea ?? '',
    user.frontIdImageName ?? '',
    user.backIdImageName ?? '',
  ]);
}
