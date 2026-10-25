
import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entities/home_product_entity.dart';
import '../entities/home_category_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<HomeProductEntity>>> getProducts({int? categoryId, int page = 1});
  Future<Either<Failure, List<HomeCategoryEntity>>> getCategories();
}