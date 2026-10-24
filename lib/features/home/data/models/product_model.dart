import '../../domain/entities/home_product_entity.dart';

class ProductModel extends HomeProductEntity {
  ProductModel({
    super.id,
    super.name,
    super.image,
    super.price,
    super.description,
    super.colors,
    super.sizes,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['title'] ?? json['name'],
      image: json['image'] ?? (json['images'] != null ? json['images'][0] : null),
      price: (json['price'] != null) ? (json['price'] as num).toDouble() : 0.0,
      description: json['description'],
      colors: json['colors'] != null ? List<String>.from(json['colors']) : [],
      sizes: json['sizes'] != null ? List<String>.from(json['sizes']) : [],
    );
  }
}