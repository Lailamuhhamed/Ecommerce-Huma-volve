
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../core/dummy_data.dart';
import '../../../../core/theme.dart';
import '../../../../services/api_service.dart';
import '../../data/data_source/data_source_impl.dart';
import '../../data/repositories/HomeRepositoryImpl.dart';
import '../../domain/use_case/get_category_use_case.dart';
import '../../domain/use_case/get_products_use_case.dart';
import '../cubit/category_cubit.dart';
import '../cubit/category_state.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';
import '../widgets/product_card.dart';
import '../widgets/category_chip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ProductCubit _productCubit;
  late final CategoryCubit _categoryCubit;
  int? _selectedCategoryId;

  @override
  void initState() {
    super.initState();

    final dio = ApiService().dio;
    final remoteDataSource = HomeRemoteDataSourceImpl(dio: dio);
    final repository = HomeRepositoryImpl(remoteDataSource: remoteDataSource);

    _productCubit = ProductCubit(
      getProductsUseCase: GetProductsUseCase(repository),
    )..fetchProducts();

    _categoryCubit = CategoryCubit(
      getCategoriesUseCase: GetCategoriesUseCase(repository),
    )..fetchCategories();
  }

  @override
  void dispose() {
    _productCubit.close();
    _categoryCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _productCubit),
        BlocProvider.value(value: _categoryCubit),
      ],
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.menu,
                              color: AppTheme.primary,
                            ),
                          ),
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(
                              dummyUser.profilePictureUrl,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Explore',
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(fontSize: 36),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Best trendy collection!',
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.05),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search clothes...',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            suffixIcon: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.tune,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      SizedBox(
                        height: 44,
                        child: BlocBuilder<CategoryCubit, CategoryState>(
                          builder: (context, state) {
                            if (state is CategoryLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: AppTheme.primary,
                                ),
                              );
                            } else if (state is CategoryLoaded) {
                              final categories = state.categories;

                              return ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length + 1,
                                separatorBuilder: (context, index) =>
                                const SizedBox(width: 12),
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return CategoryChip(
                                      label: 'All',
                                      isSelected: _selectedCategoryId == null,
                                      onTap: () {
                                        setState(() {
                                          _selectedCategoryId = null;
                                        });
                                        _productCubit.fetchProducts(categoryId: null);
                                      },
                                    );
                                  }

                                  final category = categories[index - 1];
                                  final isSelected = _selectedCategoryId == category.id;

                                  return CategoryChip(
                                    label: category.name ?? '',
                                    isSelected: isSelected,
                                    onTap: () {
                                      setState(() {
                                        _selectedCategoryId = category.id;
                                      });
                                      _productCubit.fetchProducts(categoryId: category.id);
                                    },
                                  );
                                },
                              );
                            } else if (state is CategoryError) {
                              return Center(
                                child: Text(
                                  'Error: ${state.message}',
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(color: AppTheme.primary),
                      ),
                    );
                  } else if (state is ProductLoaded) {
                    final products = state.products;
                    if (products.isEmpty) {
                      return const SliverFillRemaining(
                        child: Center(child: Text('No products found in this category')),
                      );
                    }
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return ProductCard(product: products[index]);
                        }, childCount: products.length),
                      ),
                    );
                  } else if (state is ProductError) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'Error: ${state.message}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox());
                },
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }
}