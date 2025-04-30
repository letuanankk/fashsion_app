import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductColorNotifier extends StateNotifier<int> {
  ProductColorNotifier() : super(0); // Mặc định chọn màu đầu tiên

  void selectColor(int index) => state = index;
}

final productColorProvider =
    StateNotifierProvider.family<ProductColorNotifier, int, String>(
      (ref, productId) => ProductColorNotifier(),
    );
