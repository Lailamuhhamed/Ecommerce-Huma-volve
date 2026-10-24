import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entities/home_product_entity.dart';
import '../repository/home_repository.dart';

class GetProductsUseCase {
  final HomeRepository repository;

  GetProductsUseCase(this.repository);

  Future<Either<Failure, List<HomeProductEntity>>> call({int? categoryId}) async {
    return await repository.getProducts(categoryId: categoryId);
  }
}