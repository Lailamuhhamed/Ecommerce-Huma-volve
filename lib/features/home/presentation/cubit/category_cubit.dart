import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_case/get_category_use_case.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase; //

  CategoryCubit({required this.getCategoriesUseCase}) : super(CategoryInitial());

  void fetchCategories() async {
    emit(CategoryLoading());

    final result = await getCategoriesUseCase();

    result.fold(
          (failure) => emit(CategoryError(failure.message)),
          (categories) => emit(CategoryLoaded(categories)),
    );
  }
}