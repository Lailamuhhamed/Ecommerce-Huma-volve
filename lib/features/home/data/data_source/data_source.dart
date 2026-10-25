
import '../models/category_model.dart';
import '../models/product_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<ProductModel>> getProducts({int? categoryId, int page = 1});
  Future<List<CategoryModel>> getCategories();
}