import 'package:flutter/material.dart';
import 'package:task/Providers/UserProvider.dart';
import 'package:task/services/submit_user_data.dart';

class UserSubmissionService {
  static Future<bool> submit(
    BuildContext context,
    UserProvider userProvider,
  ) async {
    try {
      await submitUserData(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data saved successfully'),
          backgroundColor: Colors.green,
        ),
      );

      return true;
    } catch (e) {
      print('Error submitting user data: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save data: $e'),
          backgroundColor: Colors.red,
        ),
      );

      return false;
    }
  }
}
