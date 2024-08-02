import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserData({
  required String name,
  required String lastName,
  required String phone,
  required String email,
  required DateTime birthDate,
  required String gender,
}) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('name', name);
  await prefs.setString('lastName', lastName);
  await prefs.setString('phone', phone);
  await prefs.setString('email', email);
  await prefs.setString('birthDate', birthDate.toIso8601String());
  await prefs.setString('gender', gender);
}

Future<Map<String, dynamic>> getUserData() async {
  final prefs = await SharedPreferences.getInstance();
  return {
    'name': prefs.getString('name') ?? '',
    'lastName': prefs.getString('lastName') ?? '',
    'phone': prefs.getString('phone') ?? '',
    'email': prefs.getString('email') ?? '',
    'birthDate': DateTime.parse(
        prefs.getString('birthDate') ?? DateTime.now().toIso8601String()),
    'gender': prefs.getString('gender') ?? '',
  };
}
