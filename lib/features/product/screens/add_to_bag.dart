import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shop_app/common/widgets/button/basic_app_button.dart';
import 'package:my_shop_app/features/cart/controller/cart_controller.dart';
import '../widgets/color_select.dart';
import '../widgets/product_quantity_select.dart';
import '../widgets/product_select_size.dart';
import '/../../common/helper/navigator/app_navigator.dart';
import '/../../common/helper/product/product_price.dart';
import '/../../data/order/models/add_to_cart_req.dart';
import '../../../data/product/entities/product.dart';
import '../../cart/screens/cart.dart';
import 'package:flutter/material.dart';

class AddToBag extends ConsumerWidget {
  final ProductEntity productEntity;
  const AddToBag({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(
      productQuantityProvider(productEntity.productId),
    );
    final selectedColorIndex = ref.watch(
      productColorProvider(productEntity.productId),
    );
    final selectedSizeIndex = ref.watch(
      productSizeProvider(productEntity.productId),
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: BasicAppButton(
        onPressed:
        // Vô hiệu hóa nút khi đang xử lý
        () async {
          try {
            // Call addToCart from CartNotifier
            await ref
                .read(cartControllerProvider)
                .addToCart(
                  AddToCartReq(
                    productId: productEntity.productId,
                    productTitle: productEntity.title,
                    productQuantity: quantity,
                    productColor:
                        productEntity.colors[selectedColorIndex].title,
                    productSize: productEntity.sizes[selectedSizeIndex],
                    productPrice: productEntity.price.toDouble(),
                    totalPrice:
                        ProductPriceHelper.provideCurrentPrice(productEntity) *
                        quantity,
                    productImage: productEntity.images[0],
                    createdDate: DateTime.now().toString(),
                  ),
                );

            AppNavigator.push(context, const CartPage());
          } catch (e) {
            // Show error message
            var snackbar = SnackBar(
              content: Text(e.toString()),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
        },
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$${(ProductPriceHelper.provideCurrentPrice(productEntity) * quantity).toString()}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const Text(
              'Add to Bag',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
