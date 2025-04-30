import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/color_select.dart';
import '/../../common/helper/bottomsheet/app_bottomsheet.dart';
import '/../../core/configs/theme/app_colors.dart';
import '../../../data/product/entities/product.dart';
import 'product_colors.dart';
import 'package:flutter/material.dart';

class SelectedColor extends ConsumerWidget {
  final ProductEntity productEntity;
  const SelectedColor({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColorIndex = ref.watch(productColorProvider(productEntity.productId));

    return GestureDetector(
      onTap: () {
        AppBottomsheet.display(
          context,
          ProductColors(
            productEntity: productEntity,
            onColorSelected: (index) {
              ref.read(productColorProvider(productEntity.productId).notifier).selectColor(index);
            },
          ),
        );
      },
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Color',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(
                      productEntity.colors[selectedColorIndex].rgb[0],
                      productEntity.colors[selectedColorIndex].rgb[1],
                      productEntity.colors[selectedColorIndex].rgb[2],
                      1,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 15),
                const Icon(Icons.keyboard_arrow_down, size: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}