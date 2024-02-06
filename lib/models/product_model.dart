import 'package:flutter/material.dart';

class ProductModel extends ChangeNotifier {
  final String title;

  final String description;

  ProductModel({
    required this.title,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: json['title'] ?? 'Default Title',
      description: json['description'] ?? 'Default Description',
    );
  }
}
