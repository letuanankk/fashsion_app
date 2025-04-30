import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/../../data/order/models/add_to_cart_req.dart';

class CartNotifier extends StateNotifier<bool> {
  CartNotifier() : super(false);

  Future<void> addToCart(AddToCartReq req) async {
    state = true; // Bắt đầu xử lý
    try {
      await FirebaseFirestore.instance.collection('Cart').add({
        'productId': req.productId,
        'productTitle': req.productTitle,
        'productQuantity': req.productQuantity,
        'productColor': req.productColor,
        'productSize': req.productSize,
        'productPrice': req.productPrice,
        'totalPrice': req.totalPrice,
        'productImage': req.productImage,
        'createdDate': req.createdDate,
      });
    } catch (e) {
      throw Exception('Failed to add product to cart. Please try again.');
    } finally {
      state = false; // Kết thúc xử lý
    }
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, bool>(
  (ref) => CartNotifier(),
);