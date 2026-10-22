import 'package:flutter/material.dart';

class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final List<Color> colors;
  final List<String> sizes;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.colors,
    required this.sizes,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> imgs = json['images'] ?? [];
    String img = imgs.isNotEmpty ? imgs[0] : 'https://i.imgur.com/LDOO21B.jpg';

    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: img,
      colors: [Colors.black, Colors.blue, Colors.grey, Colors.brown],
      sizes: ['S', 'M', 'L', 'XL'],
    );
  }
}