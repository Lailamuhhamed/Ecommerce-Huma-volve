import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../entities/home_category_entity.dart';
import '../repository/home_repository.dart';


class GetCategoriesUseCase {
  final HomeRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<Either<Failure, List<HomeCategoryEntity>>> call() async {
    return await repository.getCategories();
  }
}