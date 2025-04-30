import 'package:flutter/material.dart';
import '../../../data/product/entities/product.dart';

class ProductColors extends StatelessWidget {
  final ProductEntity productEntity;
  final void Function(int index) onColorSelected;

  const ProductColors({
    required this.productEntity,
    required this.onColorSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = productEntity.colors;

    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final color = colors[index];
        return ListTile(
          leading: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: Color.fromRGBO(
                color.rgb[0],
                color.rgb[1],
                color.rgb[2],
                1,
              ),
              shape: BoxShape.circle,
            ),
          ),
          title: Text('Color ${index + 1}'),
          onTap: () {
            onColorSelected(index);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
