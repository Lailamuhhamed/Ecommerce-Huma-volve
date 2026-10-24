// lib/features/home/domain/entities/home_product_entity.dart

class HomeProductEntity {
  final int? id;
  final String? name;
  final String? image;
  final double? price;
  final String? description;    //
  final List<String>? colors;   //
  final List<String>? sizes;

  HomeProductEntity({
    this.id,
    this.name,
    this.image,
    this.price,
    this.description,
    this.colors,
    this.sizes,
  });
}