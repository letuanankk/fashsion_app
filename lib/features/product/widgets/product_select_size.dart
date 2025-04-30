import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductSizeNotifier extends StateNotifier<int> {
  ProductSizeNotifier() : super(0); // Mặc định chọn kích thước đầu tiên

  void selectSize(int index) => state = index;
}

final productSizeProvider =
    StateNotifierProvider.family<ProductSizeNotifier, int, String>(
  (ref, productId) => ProductSizeNotifier(),
);