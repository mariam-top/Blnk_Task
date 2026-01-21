import 'dart:io';

import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  // Step 1: Basic info
  String firstName = '';
  String lastName = '';
  String email = '';
  int mobileNumber = 0;
  int landlineNumber = 0;

  // Address details
  int apartment = 0;
  int floor = 0;
  String building = '';
  String street = '';
  String landmark = '';

  // Step 2: City/Area selection
  String? selectedCity;
  String? selectedArea;

  // Step 3: National ID images
  File? idFrontImage;
  File? idBackImage;

  String? frontIdImageName;
  String? backIdImageName;

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Update basic info
  void updateBasicInfo({
    required String firstName,
    required String lastName,
    required String email,
    required int mobileNumber,
    required int landlineNumber,
    required int apartment,
    required int floor,
    required String building,
    required String street,
    required String landmark,
  }) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.mobileNumber = mobileNumber;
    this.landlineNumber = landlineNumber;
    this.apartment = apartment;
    this.floor = floor;
    this.building = building;
    this.street = street;
    this.landmark = landmark;
    notifyListeners();
  }

  void setFrontId(File file, {String? fileName}) {
    idFrontImage = file;
    if (fileName != null) frontIdImageName = fileName;
    notifyListeners();
  }

  void setBackId(File file, {String? fileName}) {
    idBackImage = file;
    if (fileName != null) backIdImageName = fileName;
    notifyListeners();
  }

  // Update city/area
  void updateCityArea({required String city, required String area}) {
    selectedCity = city;
    selectedArea = area;
    notifyListeners();
  }


  // Loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Reset all data
  void resetUserData() {
    firstName = '';
    lastName = '';
    email = '';
    mobileNumber = 0;
    landlineNumber = 0;
    apartment = 0;
    floor = 0;
    building = '';
    street = '';
    landmark = '';
    selectedCity = null;
    selectedArea = null;
    idFrontImage = null;
    idBackImage = null;
    frontIdImageName = null;
    backIdImageName = null;
    notifyListeners();
  }
}
