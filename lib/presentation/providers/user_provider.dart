import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? names;
  String? lastNames;
  String? phone;
  String? email;
  DateTime? birthDate;
  String? gender;

  

  void saveData(String names, String lastNames, String phone, String email,
      DateTime birthDate, String gender) {
    this.names = names;
    this.lastNames = lastNames;
    this.phone = phone;
    this.email = email;
    this.birthDate = birthDate;
    this.gender = gender;
    notifyListeners();
  }
}
