import 'package:ecommerce_app_huma_volve/features/home/presentation/cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_case/get_products_use_case.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase getProductsUseCase;

  ProductCubit({required this.getProductsUseCase}) : super(ProductInitial());

  void fetchProducts({int? categoryId}) async {
    emit(ProductLoading());

    final result = await getProductsUseCase(categoryId: categoryId);

    result.fold(
          (failure) => emit(ProductError(failure.message)),
          (products) => emit(ProductLoaded(products)),
    );
  }
}