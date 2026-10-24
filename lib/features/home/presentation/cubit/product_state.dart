import '../../domain/entities/home_product_entity.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}
class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<HomeProductEntity> products;
  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}