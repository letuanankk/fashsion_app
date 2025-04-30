import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductQuantityNotifier extends StateNotifier<int> {
  ProductQuantityNotifier() : super(1); // Mặc định số lượng là 1

  void increment() => state++;
  void decrement() {
    if (state > 1) state--; // Không cho phép số lượng nhỏ hơn 1
  }
}

final productQuantityProvider =
    StateNotifierProvider.family<ProductQuantityNotifier, int, String>(
  (ref, productId) => ProductQuantityNotifier(),
);