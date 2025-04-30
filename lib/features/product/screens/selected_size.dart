import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/product_select_size.dart';
import '/../../core/configs/theme/app_colors.dart';
import '../../../data/product/entities/product.dart';
import 'product_sizes.dart';
import 'package:flutter/material.dart';

import '../../../common/helper/bottomsheet/app_bottomsheet.dart';

class SelectedSize extends ConsumerWidget {
  final ProductEntity productEntity;
  const SelectedSize({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Sử dụng productId để lấy trạng thái riêng cho từng sản phẩm
    final selectedSizeIndex = ref.watch(productSizeProvider(productEntity.productId));

    return GestureDetector(
      onTap: () {
        AppBottomsheet.display(
          context,
          ProductSizes(
            productEntity: productEntity,
            onSizeSelected: (index) {
              ref.read(productSizeProvider(productEntity.productId).notifier).selectSize(index);
            },
          ),
        );
      },
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              productEntity.sizes[selectedSizeIndex].toString(),
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            Row(
              children: const [
                SizedBox(width: 15),
                Icon(Icons.keyboard_arrow_down, size: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}