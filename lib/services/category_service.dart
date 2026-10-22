import 'package:dio/dio.dart';
import '../features/auth/model/category_model.dart';
import 'api_service.dart';

class CategoryService {
  final Dio _dio = ApiService().dio;

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _dio.get('categories');

      return (response.data as List)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}