import '/../../common/widgets/appbar/app_bar.dart';
import '../../../data/product/entities/product.dart';
import 'add_to_bag.dart';
import 'package:flutter/material.dart';

import 'favorite_button.dart';
import 'selected_color.dart';
import 'product_images.dart';
import 'product_price.dart';
import 'product_quantity.dart';
import 'product_title.dart';
import 'selected_size.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDetailPage({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        hideBack: false,
        action: FavoriteButton(productEntity: productEntity),
      ),
      bottomNavigationBar: AddToBag(productEntity: productEntity),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImages(productEntity: productEntity),
            const SizedBox(height: 10),
            ProductTitle(productEntity: productEntity),
            const SizedBox(height: 10),
            ProductPrice(productEntity: productEntity),
            const SizedBox(height: 20),
            SelectedSize(productEntity: productEntity),
            const SizedBox(height: 15),
            SelectedColor(productEntity: productEntity),
            const SizedBox(height: 15),
            ProductQuantity(productEntity: productEntity),
          ],
        ),
      ),
    );
  }
}
