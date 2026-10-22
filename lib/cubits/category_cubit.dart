import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/category_service.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryService _categoryService = CategoryService();

  CategoryCubit() : super(CategoryInitial());

  void fetchCategories() async {
    emit(CategoryLoading());
    try {
      final categories = await _categoryService.getCategories();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}