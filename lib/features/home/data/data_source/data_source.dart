// lib/features/home/data/datasources/home_remote_data_source.dart

import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<HomeProductEntity>> getProducts({int? categoryId});
  Future<List<HomeCategoryEntity>> getCategories();
}