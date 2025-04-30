import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shop_app/common/widgets/loading/loading.dart';

import '../../product/controller/product_controller.dart';
import '/../../common/widgets/appbar/app_bar.dart';
import '../../product/widgets/product_card.dart';
import '../../../data/category/entity/category.dart';
import 'package:flutter/material.dart';

import '../../../data/product/entities/product.dart';

class CategoryProductsPage extends ConsumerWidget {
  final CategoryEntity categoryEntity;
  const CategoryProductsPage({required this.categoryEntity, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: FutureBuilder(
        future: ref
            .read(productControllerProvider)
            .getProductsByCategoryId(categoryEntity.categoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          List<ProductEntity> productList = snapshot.data ?? [];
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _categoryInfo(productList),
                const SizedBox(height: 10),
                _products(productList),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _categoryInfo(List<ProductEntity> products) {
    return Text(
      '${categoryEntity.title} (${products.length})',
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _products(List<ProductEntity> products) {
    return Expanded(
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.6,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(productEntity: products[index]);
        },
      ),
    );
  }
}
