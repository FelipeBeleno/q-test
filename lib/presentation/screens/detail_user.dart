import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:technical_test/presentation/preferences/preferences_service.dart';

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return FutureBuilder<Map<String, dynamic>>(
      future: getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay datos disponibles'));
        } else {
          final userData = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title:  Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Detalles del Usuario',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: color.primary,),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Nombres', userData['name']),
                  _buildDetailRow('Apellidos', userData['lastName']),
                  _buildDetailRow('Teléfono', userData['phone']),
                  _buildDetailRow('Email', userData['email']),
                  _buildDetailRow(
                      'Fecha de Nacimiento',
                      userData['birthDate'] != null
                          ? DateFormat("yyyy-MM-dd")
                              .format(userData['birthDate']?.toLocal())
                          : 'No disponible'),
                  _buildDetailRow(
                      'Edad',
                      calculateAge(userData['birthDate'])?.toString() ??
                          'No disponible'),
                  _buildDetailRow('Género', userData['gender']),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'No disponible',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  int? calculateAge(DateTime? birthDate) {
    if (birthDate == null) return null;
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}
