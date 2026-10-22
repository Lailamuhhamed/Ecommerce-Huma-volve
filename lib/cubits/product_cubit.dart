import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/products_service.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductService _productService = ProductService();

  ProductCubit() : super(ProductInitial());

  void fetchProducts({int? categoryId}) async {
    emit(ProductLoading());
    try {
      final products = await _productService.getProducts(categoryId: categoryId);
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}