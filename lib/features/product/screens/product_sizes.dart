import 'package:flutter/material.dart';
import '../../../data/product/entities/product.dart';

class ProductSizes extends StatelessWidget {
  final ProductEntity productEntity;
  final void Function(int index) onSizeSelected;

  const ProductSizes({
    required this.productEntity,
    required this.onSizeSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = productEntity.sizes;

    return ListView.builder(
      itemCount: sizes.length,
      itemBuilder: (context, index) {
        final size = sizes[index];
        return ListTile(
          title: Text(size.toString()),
          onTap: () {
            onSizeSelected(index);
            Navigator.pop(context); 
          },
        );
      },
    );
  }
}