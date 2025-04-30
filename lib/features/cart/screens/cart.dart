import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shop_app/features/cart/controller/cart_controller.dart';
import '/../../common/widgets/appbar/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/configs/assets/app_vectors.dart';
import '../../../data/order/entities/product_ordered.dart';
import '../widgets/checkout.dart';
import '../widgets/product_ordered_card.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const BasicAppbar(title: Text('Cart')),
      body: StreamBuilder(
        stream: ref.read(cartControllerProvider).getCartProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          List<ProductOrderedEntity> products = snapshot.data ?? [];
          if (products.isEmpty) {
            return _cartIsEmpty();
          }
          return Stack(
            children: [
              _products(products),
              Align(
                alignment: Alignment.bottomCenter,
                child: Checkout(products: products),
              ),
            ],
          );
        },
      ),

    );
  }

  Widget _products(List<ProductOrderedEntity> products) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return ProductOrderedCard(productOrderedEntity: products[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: products.length,
    );
  }

  Widget _cartIsEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppVectors.cartBag),
          const SizedBox(height: 20),
          const Text(
            "Cart is empty",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
