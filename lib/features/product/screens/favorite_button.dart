import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/favorite_icon_buttom.dart';
import '../../../data/product/entities/product.dart';
import 'package:flutter/material.dart';
import '../../../core/configs/theme/app_colors.dart';

class FavoriteButton extends ConsumerWidget {
  final ProductEntity productEntity;
  const FavoriteButton({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoriteProvider(productEntity.productId));

    return IconButton(
      onPressed: () async {
        await ref
            .read(favoriteProvider(productEntity.productId).notifier)
            .toggleFavorite(productEntity);
      },
      icon: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: AppColors.secondBackground,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_outline,
          size: 20,
          color: Colors.red,
        ),
      ),
    );
  }
}
