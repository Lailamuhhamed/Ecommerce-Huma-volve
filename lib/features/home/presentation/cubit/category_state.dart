// lib/cubits/category_state.dart

import '../../domain/entities/home_category_entity.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<HomeCategoryEntity> categories;
  CategoryLoaded(this.categories);
}

class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
}