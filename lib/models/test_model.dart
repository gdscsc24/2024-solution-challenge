import 'package:flutter/material.dart';

class TestModel extends ChangeNotifier {
  final int Id;
  final String Question;

  TestModel({required this.Id, required this.Question});

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
        Id: json['Id'] as int, Question: json['Question'] ?? 'Default Title');
  }
}
