import 'package:flutter/material.dart';

const List<Color> _colorThemes = [
  Colors.blue,
  Colors.deepPurple,
  Colors.teal,
  Color.fromARGB(255, 255, 230, 1),
  Colors.red,
  Colors.orange,
  Colors.green,
  Colors.pink,
  Colors.cyan,
  Colors.indigo,
  Colors.lime,
  Colors.amber,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.purple,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.deepOrange,
  Colors.blueAccent,
  Colors.greenAccent,
];

class AppTheme {
  final int selectedColor;

  AppTheme({required this.selectedColor})
      : assert(selectedColor <= _colorThemes.length - 1 && selectedColor >= 0,
            'Colors nust be between 0 and ${_colorThemes.length}');

  ThemeData theme() {
    return ThemeData(
      colorSchemeSeed: _colorThemes[selectedColor],
      appBarTheme: const AppBarTheme(centerTitle: false),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
            fontSize: 34.0, fontWeight: FontWeight.bold, color: Colors.black87),
        titleMedium: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.black54),
        bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black87),
      ),
    );
  }
}
