import 'package:flutter/material.dart';

class FieldProvider extends ChangeNotifier {
  final ScrollController textScrollController = ScrollController();



  String text;

  FieldProvider({required this.text});

  Future<void> sendText(String text) async {

    if (text.isEmpty) return;

    this.text = text;

    notifyListeners();
  }


}
