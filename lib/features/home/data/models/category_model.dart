import '../../domain/entities/home_category_entity.dart';

class CategoryModel extends HomeCategoryEntity {
  CategoryModel({
    super.id,
    super.name,
    super.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}