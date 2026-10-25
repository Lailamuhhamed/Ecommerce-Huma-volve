
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_case/get_products_use_case.dart';
import 'product_state.dart';
class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase getProductsUseCase;

  ProductCubit({required this.getProductsUseCase}) : super(ProductInitial());

  int _currentPage = 1;
  bool _isFetchingMore = false;
  bool hasMoreData = true;
  int? _currentCategoryId;

  void fetchProducts({int? categoryId, bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
      hasMoreData = true;
      _currentCategoryId = categoryId;
    }

    if (!hasMoreData && !isRefresh) return;

    if (_currentPage == 1) {
      emit(ProductLoading());
    } else {
      _isFetchingMore = true;
    }

    final result = await getProductsUseCase(
      categoryId: _currentCategoryId,
      page: _currentPage,
    );

    result.fold(
          (failure) {
        _isFetchingMore = false;
        emit(ProductError(failure.message));
      },
          (newProducts) {
        _isFetchingMore = false;

        if (newProducts.isEmpty) {
          hasMoreData = false;
          if (state is ProductLoaded) {
            emit(ProductLoaded((state as ProductLoaded).products));
          }
          return;
        }

        if (state is ProductLoaded && !isRefresh) {
          final oldProducts = (state as ProductLoaded).products;

          final bool isRepeated = oldProducts.any((oldProd) => oldProd.id == newProducts.first.id);

          if (isRepeated) {
            hasMoreData = false;
            emit(ProductLoaded(oldProducts));
            return;
          }

          _currentPage++;
          emit(ProductLoaded([...oldProducts, ...newProducts]));
        } else {
          _currentPage++;
          emit(ProductLoaded(newProducts));
        }
      },
    );
  }

  void loadMoreProducts() {
    if (_isFetchingMore || !hasMoreData) return;
    fetchProducts();
  }
}