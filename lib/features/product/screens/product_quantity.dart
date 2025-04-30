import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/product_quantity_select.dart';
import '/../../core/configs/theme/app_colors.dart';
import '../../../data/product/entities/product.dart';
import 'package:flutter/material.dart';

class ProductQuantity extends ConsumerWidget {
  final ProductEntity productEntity;
  const ProductQuantity({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(productQuantityProvider(productEntity.productId));
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Quantity',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  ref.read(productQuantityProvider(productEntity.productId).notifier).decrement();
                },
                icon: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: const Center(child: Icon(Icons.remove, size: 20)),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                quantity.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  ref.read(productQuantityProvider(productEntity.productId).notifier).increment();
                },
                icon: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: const Center(child: Icon(Icons.add, size: 20)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}