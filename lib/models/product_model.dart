import 'package:flutter/material.dart';

class ProductModel extends ChangeNotifier {
  final int contentId;
  final String title;
  final String description;
  final String imageLink;

  ProductModel({
    required this.contentId,
    required this.title,
    required this.description,
    required this.imageLink,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      contentId: json['contentId'] as int,
      title: json['title'] ?? 'Default Title',
      description: json['description'] ?? 'Default Description',
      imageLink: json['image_link'] ?? 'https://example.com/default_image.jpg',
    );
  }
}
