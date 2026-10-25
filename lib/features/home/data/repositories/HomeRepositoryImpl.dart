
import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/failure/failure.dart';

import '../../domain/entities/home_product_entity.dart';
import '../../domain/entities/home_category_entity.dart';
import '../../domain/repository/home_repository.dart';
import '../data_source/data_source.dart';


class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<HomeProductEntity>>> getProducts({int? categoryId, int page = 1}) async {
    try {
      final remoteProducts = await remoteDataSource.getProducts(categoryId: categoryId, page: page);
      return Right(remoteProducts);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<Failure, List<HomeCategoryEntity>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }
}