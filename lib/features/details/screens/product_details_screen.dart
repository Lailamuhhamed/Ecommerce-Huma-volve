
import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../home/domain/entities/home_product_entity.dart';


class ProductDetailsScreen extends StatefulWidget {
  final HomeProductEntity? product;
  final int? productId;

  const ProductDetailsScreen({
    super.key,
    this.product,
    this.productId,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  @override
  void initState() {
    super.initState();
    if (widget.productId != null) {
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    if (product == null) {
      return Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: const Center(child: CircularProgressIndicator(color: AppTheme.primary)),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: AppTheme.background,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new, size: 16),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'product-${product.id}',
                child: Image.network(
                  product.image ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              transform: Matrix4.translationValues(0.0, -32.0, 0.0),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name ?? 'No Name',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: 28,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AppTheme.primary,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}