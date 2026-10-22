import 'package:dio/dio.dart';
import '../features/auth/model/Products_model.dart';
import 'api_service.dart';

class ProductService {
  final Dio _dio = ApiService().dio;

  Future<List<ProductModel>> getProducts({int? categoryId}) async {
    try {
      final response = await _dio.get(
        'products',
        queryParameters: categoryId != null ? {'categoryId': categoryId} : null,
      );

      return (response.data as List)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}