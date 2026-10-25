
import 'package:dio/dio.dart';
import 'data_source.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductModel>> getProducts({int? categoryId, int page = 1}) async {
    final response = await dio.get(
      '/products',
      queryParameters: {
        if (categoryId != null) 'categoryId': categoryId,
        'page': page,
      },
    );

    final List data = response.data;
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await dio.get('/categories');
    final List data = response.data;
    return data.map((json) => CategoryModel.fromJson(json)).toList();
  }
}