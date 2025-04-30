import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../product/controller/product_controller.dart';
import '/../../core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../product/widgets/product_card.dart';
import '../../../data/product/entities/product.dart';

class NewIn extends ConsumerWidget {
  const NewIn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(productControllerProvider).getNewIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final List<ProductEntity> products = snapshot.data ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [_newIn(), const SizedBox(height: 20), _products(products)],
        );
      },
    );
  }
}

Widget _newIn() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Text(
      'New In',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: AppColors.primary,
      ),
    ),
  );
}

Widget _products(List<ProductEntity> products) {
  return SizedBox(
    height: 300,
    child: ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return ProductCard(productEntity: products[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(width: 10),
      itemCount: products.length,
    ),
  );
}
