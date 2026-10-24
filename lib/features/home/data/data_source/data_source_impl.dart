import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart'; // تأكدي من استيراد الـ CategoryModel
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';

import 'data_source.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<HomeProductEntity>> getProducts({int? categoryId}) async {
    final response = await dio.get(
      'products',
      queryParameters: categoryId != null ? {'categoryId': categoryId} : null,
    );

    return (response.data as List)
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<HomeCategoryEntity>> getCategories() async {
    final response = await dio.get('categories');

    return (response.data as List)
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}